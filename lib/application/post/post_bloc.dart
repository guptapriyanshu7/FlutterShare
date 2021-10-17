import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:flutter_share/domain/auth/i_auth_facade.dart';
import 'package:flutter_share/domain/auth/user.dart';
import 'package:flutter_share/domain/core/errors.dart';
import 'package:flutter_share/domain/posts/i_post_repository.dart';
import 'package:flutter_share/domain/posts/post.dart';
import 'package:flutter_share/domain/posts/post_failure.dart';

part 'post_bloc.freezed.dart';
part 'post_event.dart';
part 'post_state.dart';

@injectable
class PostBloc extends Bloc<PostEvent, PostState> {
  final IPostRepository _postRepository;
  final IAuthFacade _authFacade;

  PostBloc(this._postRepository, this._authFacade) : super(const _Initial());

  @override
  Stream<PostState> mapEventToState(
    PostEvent event,
  ) async* {
    yield* event.map(
      getPost: (value) async* {
        yield const PostState.loading();
        final Either<PostFailure, Tuple2<Post, User>> failureOrSuccess =
            await _postRepository.getPost(value.userId, value.postId);
        yield failureOrSuccess.fold(
          (f) => PostState.getPostFailure(f),
          (r) => PostState.getPostSuccess(r.value1, r.value2),
        );
      },
      read: (value) async* {
        yield const PostState.loading();
        final userOption = _authFacade.getSignedInUser();
        final currentUser =
            userOption.getOrElse(() => throw NotAuthenticatedError());
        yield* _postRepository.read(currentUser.id).map(
              (failureOrPosts) => failureOrPosts.fold(
                (f) => PostState.readFailure(f),
                (posts) => PostState.readSuccess(posts),
              ),
            );
      },
      delete: (value) async* {
        yield const PostState.loading();
        final Either<PostFailure, Unit> failureOrSuccess =
            await _postRepository.delete(value.post);
        yield failureOrSuccess.fold(
          (f) => PostState.deleteFailure(f),
          (r) => const PostState.deleteSuccess(),
        );
      },
    );
  }
}
