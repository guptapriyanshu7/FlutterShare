import 'dart:io';

import 'package:flutter_share/domain/posts/post.dart';
import 'package:flutter_share/domain/posts/post_failure.dart';
import 'package:dartz/dartz.dart';

abstract class IPostRepository {
  Stream<Either<PostFailure, List<Post>>> read();
  Future<Either<PostFailure, Unit>> create(Post post);
  Future<Either<PostFailure, String>> saveImage(File file, String postId);
  Future<Either<PostFailure, Unit>> update(Post post);
  Future<Either<PostFailure, Unit>> delete(Post post);
}
