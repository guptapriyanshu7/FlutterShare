part of 'user_actions_bloc.dart';

@freezed
class UserActionsEvent with _$UserActionsEvent {
  const factory UserActionsEvent.fetchProfile(String userId) = _FetchProfile;
  const factory UserActionsEvent.checkLikeStatus(Post post) = _CheckLikeStatus;
  const factory UserActionsEvent.likePost(bool likeStatus, Post post) = _LikePost;
  const factory UserActionsEvent.followProfile(Profile profile) = _FollowUser;
}
