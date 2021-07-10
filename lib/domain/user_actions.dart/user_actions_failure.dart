import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_actions_failure.freezed.dart';

@freezed
class UserActionsFailure with _$UserActionsFailure {
  const factory UserActionsFailure.insufficientPermissions() = _InsufficientPermissions;
  const factory UserActionsFailure.unableToFetch() = _UnableToFetch;
  const factory UserActionsFailure.notFound() = _NotFound;
}
