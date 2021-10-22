import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_share/domain/auth/user.dart';
import 'package:flutter_share/domain/user_actions/comment.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:flutter_share/domain/auth/i_auth_facade.dart';
import 'package:flutter_share/domain/core/errors.dart';
import 'package:flutter_share/domain/posts/post.dart';
import 'package:flutter_share/domain/user_actions/i_user_actions_repository.dart';
import 'package:flutter_share/domain/user_actions/profile.dart';
import 'package:flutter_share/domain/user_actions/user_actions_failure.dart';

part 'user_actions_bloc.freezed.dart';
part 'user_actions_event.dart';
part 'user_actions_state.dart';

@injectable
class UserActionsBloc extends Bloc<UserActionsEvent, UserActionsState> {
  final IUserActionsRepository _userActionsRepository;
  final IAuthFacade _authFacade;
  UserActionsBloc(this._userActionsRepository, this._authFacade)
      : super(const _Initial());

  @override
  Stream<UserActionsState> mapEventToState(
    UserActionsEvent event,
  ) async* {
    yield* event.map(
      followProfile: (e) async* {
        final isFollowingUpdate = !e.profile.isFollowing;
        final followersCountUpdate =
            e.profile.followers + (isFollowingUpdate == true ? 1 : -1);
        final userOption = await _authFacade.getSignedInUser();
        final currentUser =
            userOption.getOrElse(() => throw NotAuthenticatedError());
        _userActionsRepository.followProfile(
          isFollowingUpdate,
          e.profile.user.id,
          currentUser,
        );
        final updatedProfile = e.profile.copyWith(
          isFollowing: isFollowingUpdate,
          followers: followersCountUpdate,
        );
        yield UserActionsState.loaded(updatedProfile);
      },
      checkLikeStatus: (e) async* {
        final userOption = await _authFacade.getSignedInUser();
        final currentUser =
            userOption.getOrElse(() => throw NotAuthenticatedError());
        final isLiked = e.post.likes[currentUser.id] ?? false;
        yield UserActionsState.likeStatus(isLiked);
      },
      fetchProfile: (e) async* {
        yield const UserActionsState.loading();
        final userOption = await _authFacade.getSignedInUser();
        final currentUser =
            userOption.getOrElse(() => throw NotAuthenticatedError());
        final failureOrSuccess =
            await _userActionsRepository.fetchProfile(e.userId, currentUser.id);
        yield failureOrSuccess.fold(
          (l) => UserActionsState.error(l),
          (r) => UserActionsState.loaded(r),
        );
      },
      fetchComments: (e) async* {
        yield const UserActionsState.loading();
        yield* _userActionsRepository.fetchComments(e.postId).map(
              (failureOrComments) => failureOrComments.fold(
                (f) => UserActionsState.error(f),
                (comments) => UserActionsState.commentsLoaded(comments),
              ),
            );
      },
      likePost: (e) async* {
        final userOption = await _authFacade.getSignedInUser();
        final currentUser =
            userOption.getOrElse(() => throw NotAuthenticatedError());
        e.post.likes[currentUser.id] = e.likeStatus;
        _userActionsRepository.likePost(e.post, currentUser);
        yield UserActionsState.likeStatus(e.likeStatus);
      },
      editProfile: (e) async* {
        yield const UserActionsState.loading();
        final userOption = await _authFacade.getSignedInUser();
        final currentUser =
            userOption.getOrElse(() => throw NotAuthenticatedError());
        final updateUser =
            currentUser.copyWith(displayName: e.name, bio: e.bio);
        await _userActionsRepository.editProfile(updateUser);
        yield UserActionsState.profileUpdateSuccess(updateUser);
      },
    );
  }
}
