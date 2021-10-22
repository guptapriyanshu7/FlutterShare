part of 'user_actions_bloc.dart';

@freezed
class UserActionsState with _$UserActionsState {
  const factory UserActionsState.initial() = _Initial;
  const factory UserActionsState.loading() = _Loading;
  const factory UserActionsState.likeStatus(bool isLiked) = _LikeStatus;
  const factory UserActionsState.error(UserActionsFailure failure) = _Error;
  const factory UserActionsState.loaded(
    Profile profile,
  ) = _Loaded;
  const factory UserActionsState.commentsLoaded(
    List<Comment> comment,
  ) = _CommentsLoaded;
  const factory UserActionsState.profileUpdateSuccess(User user) = _ProfileUpdateSuccess;
}
