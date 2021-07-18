part of 'save_post_bloc.dart';

@freezed
class SavePostState with _$SavePostState {
  const factory SavePostState({
    required Post post,
    required File file,
    required bool showErrorMessages,
    required bool isEditing,
    required bool isSaving,
    required Option<PostFailure> failureOption,
  }) = _SavePost;

  factory SavePostState.initial() => SavePostState(
        isEditing: false,
        file: File('some path'),
        isSaving: false,
        post: Post.empty(),
        showErrorMessages: false,
        failureOption: none(),
      );
}
