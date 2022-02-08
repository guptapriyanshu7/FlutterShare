import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import 'package:flutter_share/domain/auth/user.dart';
import 'package:flutter_share/domain/posts/i_post_repository.dart';
import 'package:flutter_share/domain/posts/post.dart';
import 'package:flutter_share/domain/posts/post_failure.dart';
import 'package:flutter_share/infrastructure/core/firebase_helpers.dart';

@LazySingleton(as: IPostRepository)
class PostRepositoryImpl implements IPostRepository {
  final FirebaseFirestore _firestore;
  final FirebaseStorage _firebaseStorage;

  PostRepositoryImpl(this._firestore, this._firebaseStorage);

  @override
  Future<Either<PostFailure, Unit>> create(Post post) async {
    try {
      await _userPostDocRef(post.ownerid, post.id).set(post.toJson());
      return right(unit);
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        return left(const PostFailure.insufficientPermission());
      } else {
        return left(const PostFailure.unexpected());
      }
    }
  }

  DocumentReference<Map<String, dynamic>> _userAllPostsDocRef(String userId) =>
      _firestore.postsCollection.doc(userId);

  DocumentReference<Map<String, dynamic>> _userPostDocRef(
    String userId,
    String postId,
  ) =>
      _userAllPostsDocRef(userId).userPostsCollection.doc(postId);

  @override
  Future<Either<PostFailure, Unit>> delete(Post post) async {
    try {
      final postId = post.id;

      await _userPostDocRef(post.ownerid, postId).delete();

      await _firebaseStorage.refFromURL(post.mediaUrl).delete();

      final activityFeedQuerySnapshot = await _firestore.feedCollection
          .doc(post.ownerid)
          .userFeedCollection
          .where('postId', isEqualTo: postId)
          .get();
      for (final doc in activityFeedQuerySnapshot.docs) {
        doc.reference.delete();
      }

      final commentsQuerySnapshot = await _firestore.commentsCollection
          .doc(postId)
          .commentsCollection
          .get();
      for (final doc in commentsQuerySnapshot.docs) {
        doc.reference.delete();
      }

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

  Future<Tuple2<Post, User>> makeTuple(
    QueryDocumentSnapshot<Map<String, dynamic>> postDoc,
  ) async {
    final post = Post.fromJson(postDoc.data());
    final userDoc = await _firestore.getUserDoc(post.ownerid);

    final userJson = userDoc.data()!;
    final user = User.fromJson(userJson);

    return Tuple2(post, user);
  }

  @override
  Stream<Either<PostFailure, List<Tuple2<Post, User>>>> read(
    String currentUserId,
  ) async* {
    final userTimelineDoc = _firestore.timelineCollection.doc(currentUserId);
    yield* userTimelineDoc.timelinePostsCollection
        .snapshots()
        .asyncMap(
          (snapshot) =>
              Future.wait([for (var s in snapshot.docs) makeTuple(s)]),
        )
        .map((event) => right<PostFailure, List<Tuple2<Post, User>>>(event))
        .onErrorReturnWith((e, _) {
      if (e is FirebaseException && e.code == 'permission-denied') {
        return left(const PostFailure.insufficientPermission());
      } else {
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
      final postDoc = await _userPostDocRef(userId, postId).get();
      final post = Post.fromJson(postDoc.data()!);

      final userDoc = await _firestore.getUserDoc(userId);
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
