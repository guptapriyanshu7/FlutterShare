import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_share/domain/auth/i_auth_facade.dart';
import 'package:flutter_share/domain/auth/user.dart';
import 'package:flutter_share/domain/core/errors.dart';
import 'package:flutter_share/domain/posts/post.dart';
import 'package:flutter_share/domain/user_actions.dart/i_user_actions_repository.dart';
import 'package:flutter_share/domain/user_actions.dart/profile.dart';
import 'package:flutter_share/domain/user_actions.dart/user_actions_failure.dart';
import 'package:flutter_share/injection.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IUserActionsRepository)
class UserActionsRepositoryImpl implements IUserActionsRepository {
  final FirebaseFirestore _firestore;

  UserActionsRepositoryImpl(this._firestore);
  @override
  Future<Either<UserActionsFailure, Profile>> fetchProfile(
    String userId,
  ) async {
    try {
      final userDoc = await _firestore.collection('users').doc(userId).get();
      final userJson = userDoc.data();
      print(userJson);
      final userDomain = User.fromJson(userJson!);
      final followingQuery = await _firestore
          .collection('following')
          .doc(userId)
          .collection('userFollowing')
          .get();
      final followingCount = followingQuery.size;
      final followerQuery = await _firestore
          .collection('followers')
          .doc(userId)
          .collection('userFollowers')
          .get();
      final followerCount = followerQuery.size;
      final postsQuery = await _firestore
          .collection('posts')
          .doc(userId)
          .collection('userPosts')
          .get();
      final postsQueryList = postsQuery.docs;
      final postsDomainList = postsQueryList.map((postsQueryDoc) {
        final postJson = postsQueryDoc.data();
        return Post.fromJson(postJson);
      }).toList();
      final userOption = await getIt<IAuthFacade>().getSignedInUser();
      final currentUser =
          userOption.getOrElse(() => throw NotAuthenticatedError());
      final followingDoc = await _firestore
          .collection('following')
          .doc(currentUser.id)
          .collection('userFollowing')
          .doc(userId)
          .get();
      final profile = Profile(
        user: userDomain,
        currentUserId: currentUser.id,
        following: followingCount,
        followers: followerCount,
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

  @override
  Future<Option<UserActionsFailure>> likePost(Post post) async {
    try {
      final userOption = await getIt<IAuthFacade>().getSignedInUser();
      final currentUser =
          userOption.getOrElse(() => throw NotAuthenticatedError());
      getIt<FirebaseFirestore>()
          .collection('posts')
          .doc(post.ownerid)
          .collection('userPosts')
          .doc(post.id)
          .update(post.toJson());
      if (post.likes['${currentUser.id}']!) {
        getIt<FirebaseFirestore>()
            .collection('feed')
            .doc(post.ownerid)
            .collection('userFeed')
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
        getIt<FirebaseFirestore>()
            .collection('feed')
            .doc(post.ownerid)
            .collection('userFeed')
            .where('userId', isEqualTo: currentUser.id)
            .where('postId', isEqualTo: post.id)
            .where('type', isEqualTo: 'like')
            .get()
            .then((value) {
          for (final doc in value.docs) {
            doc.reference.delete();
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
  ) async {
    try {
      final userOption = await getIt<IAuthFacade>().getSignedInUser();
      final currentUser =
          userOption.getOrElse(() => throw NotAuthenticatedError());
      if (isFollowing) {
        getIt<FirebaseFirestore>()
            .collection('following')
            .doc(currentUser.id)
            .collection('userFollowing')
            .doc(userId)
            .set({});
        getIt<FirebaseFirestore>()
            .collection('followers')
            .doc(userId)
            .collection('userFollowers')
            .doc(currentUser.id)
            .set({});
        getIt<FirebaseFirestore>()
            .collection('feed')
            .doc(userId)
            .collection('userFeed')
            .add({
          'type': 'follow',
          'timestamp': DateTime.now(),
          'photoUrl': currentUser.photoUrl,
          'username': currentUser.username,
          'userId': currentUser.id,
        });
      } else {
        getIt<FirebaseFirestore>()
            .collection('following')
            .doc(currentUser.id)
            .collection('userFollowing')
            .doc(userId)
            .delete();
        getIt<FirebaseFirestore>()
            .collection('followers')
            .doc(userId)
            .collection('userFollowers')
            .doc(currentUser.id)
            .delete();
        getIt<FirebaseFirestore>()
            .collection('feed')
            .doc(userId)
            .collection('userFeed')
            .where('userId', isEqualTo: currentUser.id)
            .where('type', isEqualTo: 'follow')
            .get()
            .then(
          (value) {
            for (final doc in value.docs) {
              doc.reference.delete();
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
}
