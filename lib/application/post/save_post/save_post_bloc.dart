import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_share/domain/auth/i_auth_facade.dart';
import 'package:flutter_share/domain/core/errors.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:flutter_share/domain/posts/i_post_repository.dart';
import 'package:flutter_share/domain/posts/post.dart';
import 'package:flutter_share/domain/posts/post_failure.dart';

part 'save_post_bloc.freezed.dart';
part 'save_post_event.dart';
part 'save_post_state.dart';

@injectable
class SavePostBloc extends Bloc<SavePostEvent, SavePostState> {
  final IPostRepository _postRepository;
  final IAuthFacade _authFacade;
  SavePostBloc(this._postRepository, this._authFacade)
      : super(SavePostState.initial()) {
    on<SavePostEvent>(_onSavePostEvent);
  }

  Future<void> _onSavePostEvent(
    SavePostEvent event,
    Emitter<SavePostState> emit,
  ) async {
    await event.when(
      save: () async {
        emit(
          state.copyWith(
            isSaving: true,
            failureOption: none(),
          ),
        );
        final imageUrl =
            await _postRepository.saveImage(state.file, state.post.id);
        final imageUrll = imageUrl.fold((l) => null, id);
        final userOption = await _authFacade.getSignedInUser();
        final currentUser =
            userOption.getOrElse(() => throw NotAuthenticatedError());
        final Either<PostFailure, Unit> failureOrSuccess = state.isEditing
            ? await _postRepository.update(state.post)
            : await _postRepository.create(
                state.post
                    .copyWith(mediaUrl: imageUrll!, ownerid: currentUser.id),
              );
        emit(
          state.copyWith(
            isSaving: false,
            post: Post.empty(),
            // showErrorMessages: true,
            failureOption: failureOrSuccess.fold(
              (f) => some(f),
              (r) => none(),
            ),
          ),
        );
      },
      autoValidate: () {
        emit(
          state.copyWith(showErrorMessages: true),
        );
      },
      captionChanged: (String value) {
        emit(
          state.copyWith(
            post: state.post.copyWith(caption: value),
            // failureOption: none(),
          ),
        );
      },
      filePicked: (File file) {
        emit(
          state.copyWith(
            file: file,
            // failureOption: none(),
          ),
        );
      },
      locationChanged: (String value) {
        emit(
          state.copyWith(
            post: state.post.copyWith(location: value),
            // failureOption: none(),
          ),
        );
      },
    );
  }
}
