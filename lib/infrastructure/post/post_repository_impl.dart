import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_share/domain/auth/i_auth_facade.dart';
import 'package:flutter_share/domain/auth/user.dart';
import 'package:flutter_share/domain/core/errors.dart';
import 'package:flutter_share/domain/posts/i_post_repository.dart';
import 'package:flutter_share/domain/posts/post_failure.dart';
import 'package:flutter_share/domain/posts/post.dart';
import 'package:flutter_share/injection.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_share/infrastructure/core/firebase_helpers.dart';

@LazySingleton(as: IPostRepository)
class PostRepositoryImpl implements IPostRepository {
  final FirebaseFirestore _firestore;
  final FirebaseStorage _firebaseStorage;
  PostRepositoryImpl(this._firestore, this._firebaseStorage);

  @override
  Future<Either<PostFailure, Unit>> create(Post post) async {
    final currentUser = getIt<IAuthFacade>()
        .getSignedInUser()
        .getOrElse(() => throw NotAuthenticatedError());
    try {
      final userPostsDoc = _firestore.postsCollection.doc(currentUser.id);
      await userPostsDoc.userPostsCollection.doc(post.id).set(post.toJson());
      return right(unit);
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        return left(const PostFailure.insufficientPermission());
      } else {
        return left(const PostFailure.unexpected());
      }
    }
  }

  @override
  Future<Either<PostFailure, Unit>> delete(Post post) async {
    final currentUser = getIt<IAuthFacade>()
        .getSignedInUser()
        .getOrElse(() => throw NotAuthenticatedError());
    try {
      final userPostsDoc = _firestore.postsCollection.doc(currentUser.id);
      final postId = post.id;
      await userPostsDoc.userPostsCollection.doc(postId).delete();
      return right(unit);
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        return left(const PostFailure.insufficientPermission());
      } else if (e.code == 'not-found') {
        return left(const PostFailure.unableToDelete());
      } else {
        return left(const PostFailure.unexpected());
      }
    }
  }

  @override
  Stream<Either<PostFailure, List<Post>>> read() async* {
    final currentUser = getIt<IAuthFacade>()
        .getSignedInUser()
        .getOrElse(() => throw NotAuthenticatedError());
    final userTimelineDoc = _firestore.timelineCollection.doc(currentUser.id);
    yield* userTimelineDoc.timelinePostsCollection.snapshots().map((snapshot) {
      return right<PostFailure, List<Post>>(
        snapshot.docs.map((doc) {
          final note = Post.fromJson(doc.data());
          return note;
        }).toList(),
      );
    }).onErrorReturnWith((e, _) {
      if (e is FirebaseException && e.code == 'permission-denied') {
        print(e);
        return left(const PostFailure.insufficientPermission());
      } else {
        print(e);
        return left(const PostFailure.unexpected());
      }
    });
  }

  @override
  Future<Either<PostFailure, Unit>> update(Post post) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<Either<PostFailure, String>> saveImage(
    File file,
    String postId,
  ) async {
    final taskSnap =
        await _firebaseStorage.ref('postImg_$postId.jpg').putFile(file);
    return right(await taskSnap.ref.getDownloadURL());
  }

  @override
  Future<Either<PostFailure, Tuple2<Post, User>>> getPost(
    String userId,
    String postId,
  ) async {
    try {
      final userPostsDoc = _firestore.postsCollection.doc(userId);
      final postDoc = await userPostsDoc.userPostsCollection.doc(postId).get();
      final post = Post.fromJson(postDoc.data()!);

      final userDoc = await _firestore.usersCollection.doc(userId).get();
      final user = User.fromJson(userDoc.data()!);

      return right(Tuple2(post, user));
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        return left(const PostFailure.insufficientPermission());
      } else if (e.code == 'not-found') {
        return left(const PostFailure.unableToDelete());
      } else {
        return left(const PostFailure.unexpected());
      }
    }
  }
}
