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

  PostBloc(this._postRepository, this._authFacade)
      : super(const PostState.initial()) {
    on<PostEvent>(_onPostEvent);
  }

  Future<void> _onPostEvent(
    PostEvent event,
    Emitter<PostState> emit,
  ) async {
    await event.when(
      getPost: (String userId, String postId) async {
        emit(const PostState.loading());

        final Either<PostFailure, Tuple2<Post, User>> failureOrSuccess =
            await _postRepository.getPost(userId, postId);

        emit(
          failureOrSuccess.fold(
            (f) => PostState.getPostFailure(f),
            (r) => PostState.getPostSuccess(r.value1, r.value2),
          ),
        );
      },
      read: () async {
        emit(const PostState.loading());

        final userOption = await _authFacade.getSignedInUser();
        final currentUser =
            userOption.getOrElse(() => throw NotAuthenticatedError());

        await emit.forEach(
          _postRepository.read(currentUser.id),
          onData: (
            Either<PostFailure, List<Tuple2<Post, User>>> failureOrPosts,
          ) =>
              failureOrPosts.fold(
            (f) => PostState.readFailure(f),
            (posts) => PostState.readSuccess(posts),
          ),
          onError: (_, __) =>
              const PostState.readFailure(PostFailure.unexpected()),
        );
      },
      delete: (Post post) async {
        emit(const PostState.loading());

        final Either<PostFailure, Unit> failureOrSuccess =
            await _postRepository.delete(post);

        failureOrSuccess.fold(
          (f) => emit(PostState.deleteFailure(f)),
          (r) => emit(const PostState.deleteSuccess()),
        );
      },
    );
  }
}
