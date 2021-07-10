part of 'user_actions_bloc.dart';

@freezed
class UserActionsState with _$UserActionsState {
  const factory UserActionsState.initial() = _Initial;
  const factory UserActionsState.loading() = Loading;
  const factory UserActionsState.error(UserActionsFailure failure) = Error;
  const factory UserActionsState.loaded(
    Profile profile
  ) = _Loaded;
}
