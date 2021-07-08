part of 'post_bloc.dart';

@freezed
class PostEvent with _$PostEvent {
  const factory PostEvent.read() = _Read;

  const factory PostEvent.delete(Post post) = _Delete;
}
