import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_share/domain/posts/i_post_repository.dart';
import 'package:flutter_share/domain/posts/post.dart';
import 'package:flutter_share/domain/posts/post_failure.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'save_post_event.dart';
part 'save_post_state.dart';
part 'save_post_bloc.freezed.dart';

@injectable
class SavePostBloc extends Bloc<SavePostEvent, SavePostState> {
  final IPostRepository _postRepository;
  SavePostBloc(this._postRepository) : super(SavePostState.initial());
  @override
  Stream<SavePostState> mapEventToState(
    SavePostEvent event,
  ) async* {
    yield* event.map(
      save: (_) async* {
        yield state.copyWith(
          isSaving: true,
          failureOption: none(),
        );
        final imageUrl =
            await _postRepository.saveImage(state.file, state.post.id);
        final imageUrll = imageUrl.fold((l) => null, id);
        Either<PostFailure, Unit> failureOrSuccess = state.isEditing
            ? await _postRepository.update(state.post)
            : await _postRepository.create(
                state.post.copyWith(
                  mediaUrl: imageUrll!,
                ),
              );
        yield state.copyWith(
          isSaving: false,
          post: Post.empty(),
          // showErrorMessages: true,
          failureOption: failureOrSuccess.fold(
            (f) => some(f),
            (r) => none(),
          ),
        );
      },
      autoValidate: (_) async* {
        yield state.copyWith(
          showErrorMessages: true,
        );
      },
      captionChanged: (e) async* {
        yield state.copyWith(
          post: state.post.copyWith(
            caption: e.value,
          ),
          // failureOption: none(),
        );
      },
      filePicked: (e) async* {
        yield state.copyWith(
          file: e.file,
          // failureOption: none(),
        );
      },
      locationChanged: (e) async* {
        yield state.copyWith(
          post: state.post.copyWith(
            location: e.value,
          ),
          // failureOption: none(),
        );
      },
    );
  }
}
