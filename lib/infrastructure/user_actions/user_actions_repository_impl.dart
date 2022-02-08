import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_share/domain/user_actions/comment.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import 'package:flutter_share/domain/auth/user.dart';
import 'package:flutter_share/domain/posts/post.dart';
import 'package:flutter_share/domain/user_actions/i_user_actions_repository.dart';
import 'package:flutter_share/domain/user_actions/profile.dart';
import 'package:flutter_share/domain/user_actions/user_actions_failure.dart';
import 'package:flutter_share/infrastructure/core/firebase_helpers.dart';

@LazySingleton(as: IUserActionsRepository)
class UserActionsRepositoryImpl implements IUserActionsRepository {
  final FirebaseFirestore _firestore;
  UserActionsRepositoryImpl(this._firestore);

  @override
  Future<Either<UserActionsFailure, Profile>> fetchProfile(
    String userId,
    String currentUserId,
  ) async {
    try {
      final userDoc = await _firestore.getUserDoc(userId);
      final userJson = userDoc.data();
      final userDomain = User.fromJson(userJson!);

      final followingCount = await _getTotalFollowing(userId);

      final followersCount = await _getTotalFollowers(userId);

      final postsQuery = await _firestore.postsCollection
          .doc(userId)
          .userPostsCollection
          .get();
      final postsQueryList = postsQuery.docs;
      final postsDomainList = postsQueryList.map((postsQueryDoc) {
        final postJson = postsQueryDoc.data();
        return Post.fromJson(postJson);
      }).toList();

      final followingDoc = await _firestore.followingCollection
          .doc(currentUserId)
          .userFollowingCollection
          .doc(userId)
          .get();

      final profile = Profile(
        user: userDomain,
        currentUserId: currentUserId,
        following: followingCount,
        followers: followersCount,
        posts: postsDomainList,
        isFollowing: followingDoc.exists,
      );

      return right(profile);
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        return left(const UserActionsFailure.insufficientPermissions());
      } else if (e.code == 'not-found') {
        return left(const UserActionsFailure.notFound());
      } else {
        return left(const UserActionsFailure.unableToFetch());
      }
    }
  }

  Future<int> _getTotalFollowers(String userId) async {
    final followerQuery = await _firestore.followersCollection
        .doc(userId)
        .userFollowersCollection
        .get();
    return followerQuery.size;
  }

  Future<int> _getTotalFollowing(String userId) async {
    final followingQuery = await _firestore.followingCollection
        .doc(userId)
        .userFollowingCollection
        .get();
    return followingQuery.size;
  }

  @override
  Future<Option<UserActionsFailure>> likePost(
    Post post,
    User currentUser,
  ) async {
    try {
      await _firestore.postsCollection
          .doc(post.ownerid)
          .userPostsCollection
          .doc(post.id)
          .update(post.toJson());
      if (post.likes[currentUser.id]!) {
        await _firestore.feedCollection
            .doc(post.ownerid)
            .userFeedCollection
            .add({
          'type': 'like',
          'timestamp': DateTime.now(),
          'photoUrl': currentUser.photoUrl,
          'username': currentUser.username,
          'userId': currentUser.id,
          'postId': post.id,
          "mediaUrl": post.mediaUrl,
        });
      } else {
        _firestore.feedCollection
            .doc(post.ownerid)
            .userFeedCollection
            .where('userId', isEqualTo: currentUser.id)
            .where('postId', isEqualTo: post.id)
            .where('type', isEqualTo: 'like')
            .get()
            .then((value) async {
          for (final doc in value.docs) {
            await doc.reference.delete();
          }
        });
      }
      return none();
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        return some(const UserActionsFailure.insufficientPermissions());
      } else if (e.code == 'not-found') {
        return some(const UserActionsFailure.notFound());
      } else {
        return some(const UserActionsFailure.unableToFetch());
      }
    }
  }

  @override
  Future<Option<UserActionsFailure>> followProfile(
    bool isFollowing,
    String userId,
    User currentUser,
  ) async {
    try {
      if (isFollowing) {
        await _firestore.followingCollection
            .doc(currentUser.id)
            .userFollowingCollection
            .doc(userId)
            .set({});
        await _firestore.followersCollection
            .doc(userId)
            .userFollowersCollection
            .doc(currentUser.id)
            .set({});
        await _firestore.feedCollection.doc(userId).userFeedCollection.add({
          'type': 'follow',
          'timestamp': DateTime.now(),
          'photoUrl': currentUser.photoUrl,
          'username': currentUser.username,
          'userId': currentUser.id,
        });
      } else {
        await _firestore.followingCollection
            .doc(currentUser.id)
            .userFollowingCollection
            .doc(userId)
            .delete();
        await _firestore.followersCollection
            .doc(userId)
            .userFollowersCollection
            .doc(currentUser.id)
            .delete();
        _firestore.feedCollection
            .doc(userId)
            .userFeedCollection
            .where('userId', isEqualTo: currentUser.id)
            .where('type', isEqualTo: 'follow')
            .get()
            .then(
          (value) async {
            for (final doc in value.docs) {
              await doc.reference.delete();
            }
          },
        );
      }
      return none();
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        return some(const UserActionsFailure.insufficientPermissions());
      } else if (e.code == 'not-found') {
        return some(const UserActionsFailure.notFound());
      } else {
        return some(const UserActionsFailure.unableToFetch());
      }
    }
  }

  @override
  Stream<Either<UserActionsFailure, List<Comment>>> fetchComments(
    String postId,
  ) async* {
    final postCommentsDoc = _firestore.commentsCollection.doc(postId);
    yield* postCommentsDoc.commentsCollection
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map(
          (snapshot) => right<UserActionsFailure, List<Comment>>(
            snapshot.docs.map((doc) => Comment.fromJson(doc.data())).toList(),
          ),
        )
        .onErrorReturnWith((e, _) {
      if (e is FirebaseException) {
        if (e.code == 'permission-denied') {
          return left(const UserActionsFailure.insufficientPermissions());
        } else if (e.code == 'not-found') {
          return left(const UserActionsFailure.notFound());
        } else {
          return left(const UserActionsFailure.unableToFetch());
        }
      } else {
        return left(const UserActionsFailure.unableToFetch());
      }
    });
  }

  @override
  Future<Option<UserActionsFailure>> editProfile(User user) async {
    try {
      await _firestore.usersCollection.doc(user.id).update(user.toJson());
      return none();
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        return some(const UserActionsFailure.insufficientPermissions());
      } else if (e.code == 'not-found') {
        return some(const UserActionsFailure.notFound());
      } else {
        return some(const UserActionsFailure.unableToFetch());
      }
    }
  }

  //  @override
  // Future<Option<UserActionsFailure>> addComment(
  //   bool isFollowing,
  //   String userId,
  // ) async {
  //   final currentUser = getIt<IAuthFacade>()
  //       .getSignedInUser()
  //       .getOrElse(() => throw NotAuthenticatedError());
  //   try {
  //     if (isFollowing) {
  //       await _firestore.followingCollection
  //           .doc(currentUser.id)
  //           .userFollowingCollection
  //           .doc(userId)
  //           .set({});
  //       await _firestore.followersCollection
  //           .doc(userId)
  //           .userFollowersCollection
  //           .doc(currentUser.id)
  //           .set({});
  //       await _firestore.feedCollection.doc(userId).userFeedCollection.add({
  //         'type': 'follow',
  //         'timestamp': DateTime.now(),
  //         'photoUrl': currentUser.photoUrl,
  //         'username': currentUser.username,
  //         'userId': currentUser.id,
  //       });
  //     } else {
  //       await _firestore.followingCollection
  //           .doc(currentUser.id)
  //           .userFollowingCollection
  //           .doc(userId)
  //           .delete();
  //       await _firestore.followersCollection
  //           .doc(userId)
  //           .userFollowersCollection
  //           .doc(currentUser.id)
  //           .delete();
  //       _firestore.feedCollection
  //           .doc(userId)
  //           .userFeedCollection
  //           .where('userId', isEqualTo: currentUser.id)
  //           .where('type', isEqualTo: 'follow')
  //           .get()
  //           .then(
  //         (value) async {
  //           for (final doc in value.docs) {
  //             await doc.reference.delete();
  //           }
  //         },
  //       );
  //     }
  //     return none();
  //   } on FirebaseException catch (e) {
  //     if (e.code == 'permission-denied') {
  //       return some(const UserActionsFailure.insufficientPermissions());
  //     } else if (e.code == 'not-found') {
  //       return some(const UserActionsFailure.notFound());
  //     } else {
  //       return some(const UserActionsFailure.unableToFetch());
  //     }
  //   }
  // }
}
