import 'package:cloud_firestore/cloud_firestore.dart';

extension FirebaseFirestoreX on FirebaseFirestore {
  CollectionReference<Map<String, dynamic>> get usersCollection =>
      collection('users');
  CollectionReference<Map<String, dynamic>> get timelineCollection =>
      collection('timeline');
  CollectionReference<Map<String, dynamic>> get postsCollection =>
      collection('posts');
  CollectionReference<Map<String, dynamic>> get followingCollection =>
      collection('following');
  CollectionReference<Map<String, dynamic>> get followersCollection =>
      collection('followers');
  CollectionReference<Map<String, dynamic>> get feedCollection =>
      collection('feed');
  CollectionReference<Map<String, dynamic>> get commentsCollection =>
      collection('comments');
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDoc(
    String firebaseUserId,
  ) =>
      usersCollection.doc(firebaseUserId).get();
}

extension DocumentReferenceX on DocumentReference {
  CollectionReference<Map<String, dynamic>> get timelinePostsCollection =>
      collection('timelinePosts');
  CollectionReference<Map<String, dynamic>> get userPostsCollection =>
      collection('userPosts');
  CollectionReference<Map<String, dynamic>> get userFollowingCollection =>
      collection('userFollowing');
  CollectionReference<Map<String, dynamic>> get userFollowersCollection =>
      collection('userFollowers');
  CollectionReference<Map<String, dynamic>> get userFeedCollection =>
      collection('userFeed');
  CollectionReference<Map<String, dynamic>> get commentsCollection =>
      collection('comments');
}
