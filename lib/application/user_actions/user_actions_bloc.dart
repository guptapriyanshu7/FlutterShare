import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_share/domain/auth/i_auth_facade.dart';
import 'package:flutter_share/domain/core/errors.dart';
import 'package:flutter_share/domain/posts/post.dart';
import 'package:flutter_share/domain/user_actions/profile.dart';
import 'package:flutter_share/injection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_share/domain/user_actions/i_user_actions_repository.dart';
import 'package:flutter_share/domain/user_actions/user_actions_failure.dart';
import 'package:injectable/injectable.dart';

part 'user_actions_bloc.freezed.dart';
part 'user_actions_event.dart';
part 'user_actions_state.dart';

@injectable
class UserActionsBloc extends Bloc<UserActionsEvent, UserActionsState> {
  final IUserActionsRepository _userActionsRepository;
  UserActionsBloc(this._userActionsRepository) : super(_Initial());

  @override
  Stream<UserActionsState> mapEventToState(
    UserActionsEvent event,
  ) async* {
    yield* event.map(
      followProfile: (e) async* {
        final isFollowingUpdate = !e.profile.isFollowing;
        final followersCountUpdate =
            e.profile.followers + (isFollowingUpdate == true ? 1 : -1);
        _userActionsRepository.followProfile(
          isFollowingUpdate,
          e.profile.user.id,
        );
        final updatedProfile = e.profile.copyWith(
            isFollowing: isFollowingUpdate, followers: followersCountUpdate);
        yield UserActionsState.loaded(updatedProfile);
      },
      checkLikeStatus: (e) async* {
        final userOption = await getIt<IAuthFacade>().getSignedInUser();
        final currentUser =
            userOption.getOrElse(() => throw NotAuthenticatedError());
        final isLiked = e.post.likes[currentUser.id] ?? false;
        yield UserActionsState.likeStatus(isLiked);
      },
      fetchProfile: (e) async* {
        yield UserActionsState.loading();
        final failureOrSuccess =
            await _userActionsRepository.fetchProfile(e.userId);
        yield failureOrSuccess.fold(
          (l) => UserActionsState.error(l),
          (r) => UserActionsState.loaded(r),
        );
      },
      likePost: (e) async* {
        final userOption = await getIt<IAuthFacade>().getSignedInUser();
        final currentUser =
            userOption.getOrElse(() => throw NotAuthenticatedError());
        // final likesMap = e.post.likes;
        // final updatedLikesMap = likesMap.map((key, value) {
        //   if (key == currentUser.id) {
        //     return MapEntry(key, e.likeStatus);
        //   }
        //   return MapEntry(key, value);
        // });
        // final updatedPost = e.post.copyWith(likes: updatedLikesMap);
        e.post.likes[currentUser.id] = e.likeStatus;
        _userActionsRepository.likePost(e.post);
        yield UserActionsState.likeStatus(e.likeStatus);
      },
    );
  }
}
