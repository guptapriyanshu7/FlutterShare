import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_share/domain/auth/user.dart';
import 'package:flutter_share/domain/posts/i_post_repository.dart';
import 'package:flutter_share/domain/posts/post.dart';
import 'package:flutter_share/domain/posts/post_failure.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'post_event.dart';
part 'post_state.dart';
part 'post_bloc.freezed.dart';

@injectable
class PostBloc extends Bloc<PostEvent, PostState> {
  final IPostRepository _postRepository;
  PostBloc(this._postRepository) : super(_Initial());

  @override
  Stream<PostState> mapEventToState(
    PostEvent event,
  ) async* {
    yield* event.map(
      getPost: (value) async* {
        yield PostState.loading();
        Either<PostFailure, Tuple2<Post, User>> failureOrSuccess =
            await _postRepository.getPost(value.userId, value.postId);
        yield failureOrSuccess.fold(
          (f) => PostState.getPostFailure(f),
          (r) => PostState.getPostSuccess(r.value1, r.value2),
        );
      },
      read: (value) async* {
        yield PostState.loading();
        _postRepository.read().forEach((element) {
          print(element);
        });
        yield* _postRepository.read().map(
              (failureOrPosts) => failureOrPosts.fold(
                (f) => PostState.readFailure(f),
                (posts) => PostState.readSuccess(posts),
              ),
            );
      },
      delete: (value) async* {
        yield PostState.loading();
        Either<PostFailure, Unit> failureOrSuccess =
            await _postRepository.delete(value.post);
        yield failureOrSuccess.fold(
          (f) => PostState.deleteFailure(f),
          (r) => PostState.deleteSuccess(),
        );
      },
    );
  }
}
