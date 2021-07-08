import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_share/domain/posts/i_post_repository.dart';
import 'package:flutter_share/domain/posts/post_failure.dart';
import 'package:flutter_share/domain/posts/post.dart';
import 'package:flutter_share/injection.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@LazySingleton(as: IPostRepository)
class PostRepositoryImpl implements IPostRepository {
  final FirebaseFirestore _firestore;

  PostRepositoryImpl(this._firestore);
  @override
  Future<Either<PostFailure, Unit>> create(Post post) async {
    try {
      final userDoc = await getIt<FirebaseFirestore>()
          .collection('posts')
          .doc('fsdfsfdfsfs');
      // final postDto = postDto.fromDomain(post);
      await userDoc.collection('userPosts').doc(post.id).set(post.toJson());
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
    try {
      final userDoc = await _firestore.collection('users').doc('fsdfsfdfsfs');
      final noteId = post.id;
      await userDoc.collection('userPosts').doc(noteId).delete();
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
    final userDoc = await _firestore
        .collection('posts')
        .doc('5QNxqcDLc5hrjox6Hf0VAbADLqy2');
    print(userDoc);
    yield* userDoc
        .collection('userPosts')
        // .orderBy('serverTimeStamp', descending: true)
        .snapshots()
        .map((snapshot) {
      print(snapshot.docs);
      return right<PostFailure, List<Post>>(
        snapshot.docs.map((doc) {
          print(doc.data());
          final note = Post.fromJson(doc.data());
          print(note.caption);
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
}
