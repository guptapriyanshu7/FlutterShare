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
      : super(const UserActionsState.initial()) {
    on<UserActionsEvent>(_onUserActionsEvent);
  }

  Future<void> _onUserActionsEvent(
    UserActionsEvent event,
    Emitter<UserActionsState> emit,
  ) async {
    await event.when(
      followProfile: (Profile profile) async {
        final isFollowingUpdate = !profile.isFollowing;
        final followersCountUpdate =
            profile.followers + (isFollowingUpdate == true ? 1 : -1);

        final userOption = await _authFacade.getSignedInUser();
        final currentUser =
            userOption.getOrElse(() => throw NotAuthenticatedError());

        _userActionsRepository.followProfile(
          isFollowingUpdate,
          profile.user.id,
          currentUser,
        );
        final updatedProfile = profile.copyWith(
          isFollowing: isFollowingUpdate,
          followers: followersCountUpdate,
        );

        emit(UserActionsState.loaded(updatedProfile));
      },
      checkLikeStatus: (Post post) async {
        final userOption = await _authFacade.getSignedInUser();
        final currentUser =
            userOption.getOrElse(() => throw NotAuthenticatedError());

        final isLiked = post.likes[currentUser.id] ?? false;

        emit(UserActionsState.likeStatus(isLiked));
      },
      fetchProfile: (String userId) async {
        emit(const UserActionsState.loading());

        final userOption = await _authFacade.getSignedInUser();
        final currentUser =
            userOption.getOrElse(() => throw NotAuthenticatedError());

        final failureOrSuccess =
            await _userActionsRepository.fetchProfile(userId, currentUser.id);

        emit(
          failureOrSuccess.fold(
            (l) => UserActionsState.error(l),
            (r) => UserActionsState.loaded(r),
          ),
        );
      },
      fetchComments: (String postId) async {
        emit(const UserActionsState.loading());

        _userActionsRepository.fetchComments(postId).map(
              (failureOrComments) => failureOrComments.fold(
                (f) => emit(UserActionsState.error(f)),
                (comments) => emit(UserActionsState.commentsLoaded(comments)),
              ),
            );
      },
      likePost: (bool likeStatus, Post post) async {
        final userOption = await _authFacade.getSignedInUser();

        final currentUser =
            userOption.getOrElse(() => throw NotAuthenticatedError());

        post.likes[currentUser.id] = likeStatus;
        _userActionsRepository.likePost(post, currentUser);

        emit(UserActionsState.likeStatus(likeStatus));
      },
      editProfile: (String name, String bio) async {
        emit(const UserActionsState.loading());

        final userOption = await _authFacade.getSignedInUser();
        final currentUser =
            userOption.getOrElse(() => throw NotAuthenticatedError());

        final updateUser = currentUser.copyWith(displayName: name, bio: bio);
        await _userActionsRepository.editProfile(updateUser);

        emit(UserActionsState.profileUpdateSuccess(updateUser));
      },
    );
  }
}
