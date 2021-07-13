const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

exports.onCreateFollower = functions.firestore
  .document('/followers/{userId}/userFollowers/{followerId}')
  .onCreate(async (snapshot, context) => {
    console.log('Follower Created', snapshot.data());
    const userId = context.params.userId;
    const followerId = context.params.followerId;

    // 1) Create followed users posts ref
    const followedUserPostsRef = admin
      .firestore()
      .collection('posts')
      .doc(userId)
      .collection('userPosts');

    // 2) Create following user's timeline ref
    const timelinePostsRef = admin
      .firestore()
      .collection('timeline')
      .doc(followerId)
      .collection('timelinePosts');

    // 3) Get followed users posts
    const querySnapshot = await followedUserPostsRef.get();

    // 4) Add each user post to following user's timeline
    querySnapshot.forEach((doc) => {
      if (doc.exists) {
        const postId = doc.id;
        const postData = doc.data();
        timelinePostsRef.doc(postId).set(postData);
      }
    });
  });

exports.onDeleteFollower = functions.firestore
  .document('/followers/{userId}/userFollowers/{followerId}')
  .onDelete(async (snapshot, context) => {
    console.log('Follower Deleted', snapshot.data());
    const userId = context.params.userId;
    const followerId = context.params.followerId;
    console.log(userId, followerId);
    // 2) Create following user's timeline ref
    const timelinePostsRef = admin
      .firestore()
      .collection('timeline')
      .doc(followerId)
      .collection('timelinePosts')
      .where('ownerid', '==', userId);

    // 3) Get followed users posts
    const querySnapshot = await timelinePostsRef.get();

    // 4) Add each user post to following user's timeline
    querySnapshot.forEach((doc) => {
      if (doc.exists) {
        console.log(doc.data());
        doc.ref.delete();
      }
    });
  });

exports.onUpdatePost = functions.firestore
  .document('/posts/{userId}/userPosts/{postId}')
  .onUpdate(async (change, context) => {
    const postUpdated = change.after.data();
    const userId = context.params.userId;
    const postId = context.params.postId;

    const userFollowersRef = admin
      .firestore()
      .collection('followers')
      .doc(userId)
      .collection('userFollowers');

    const querySnapshot = await userFollowersRef.get();
    querySnapshot.forEach((doc) => {
      const followerId = doc.id;
      admin
        .firestore()
        .collection('timeline')
        .doc(followerId)
        .collection('timelinePosts')
        .doc(postId)
        .update(postUpdated);
    });
  });

exports.onCreatePost = functions.firestore
  .document('/posts/{userId}/userPosts/{postId}')
  .onCreate(async (snapshot, context) => {
    const postCreated = snapshot.data();
    const userId = context.params.userId;
    const postId = context.params.postId;

    const userFollowersRef = admin
      .firestore()
      .collection('followers')
      .doc(userId)
      .collection('userFollowers');

    const querySnapshot = await userFollowersRef.get();

    querySnapshot.forEach((doc) => {
      const followerId = doc.id;

      admin
        .firestore()
        .collection('timeline')
        .doc(followerId)
        .collection('timelinePosts')
        .doc(postId)
        .set(postCreated);
    });
  });

exports.onCreateActivityFeedItem = functions.firestore
  .document('/feed/{userId}/userFeed/{activityFeedItem}')
  .onCreate(async (snapshot, context) => {
    console.log('Activity feed item created', snapshot.data());

    const userId = context.params.userId;

    const userRef = admin.firestore().doc(`users/${userId}`);
    const doc = await userRef.get();

    const androidNotificationToken = doc.data().androidNotificationToken;

    const createdActivityFeedItem = snapshot.data();

    if (androidNotificationToken) {
      sendNotification(androidNotificationToken, createdActivityFeedItem);
    } else {
      console.log('No token found');
    }

    function sendNotification(androidNotificationToken, activityFeedItem) {
      let body;

      switch (activityFeedItem.type) {
        case 'comment':
          body = `${activityFeedItem.username} replied: ${activityFeedItem.comment}`;
          break;
        case 'like':
          body = `${activityFeedItem.username} liked your post`;
          break;
        case 'follow':
          body = `${activityFeedItem.username} followed you`;
          break;
        default:
          break;
      }

      const message = {
        notification: { body },
        token: androidNotificationToken,
        data: { recipient: userId },
      };

      admin
        .messaging()
        .send(message)
        .then((response) => {
          console.log('message sent ', response);
        })
        .catch((error) => {
          console.log('error was ', error);
        });
    }
  });
