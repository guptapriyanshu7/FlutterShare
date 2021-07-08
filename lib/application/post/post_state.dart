part of 'post_bloc.dart';

@freezed
class PostState with _$PostState {
  const factory PostState.initial() = _Initial;
  const factory PostState.loading() = _Loading;

  const factory PostState.readSuccess(List<Post> posts) = _ReadSuccess;
  const factory PostState.readFailure(PostFailure failure) = _ReadFailure;


  const factory PostState.deleteFailure(PostFailure failure) = _DeleteFailure;
  const factory PostState.deleteSuccess() = _DeleteSuccess;
}
