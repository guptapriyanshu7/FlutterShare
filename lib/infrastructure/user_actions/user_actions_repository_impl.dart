import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_share/domain/auth/user.dart';
import 'package:flutter_share/domain/posts/post.dart';
import 'package:flutter_share/domain/user_actions.dart/i_user_actions_repository.dart';
import 'package:flutter_share/domain/user_actions.dart/profile.dart';
import 'package:flutter_share/domain/user_actions.dart/user_actions_failure.dart';
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
          .collection('follower')
          .doc(userId)
          .collection('userFollower')
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
      final profile = Profile(
        user: userDomain,
        following: followingCount,
        followers: followerCount,
        posts: postsDomainList,
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
}
