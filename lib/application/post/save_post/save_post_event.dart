part of 'save_post_bloc.dart';

@freezed
class SavePostEvent with _$SavePostEvent {
  const factory SavePostEvent.save() = _Save;
  const factory SavePostEvent.autoValidate() = _AutoValidate;
  const factory SavePostEvent.captionChanged(String value) = _CaptionChanged;
  const factory SavePostEvent.locationChanged(String value) = _LocationChanged;
  const factory SavePostEvent.filePicked(File file) = _FilePicked;
}
