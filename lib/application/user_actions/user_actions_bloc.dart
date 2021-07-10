import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_share/domain/user_actions.dart/profile.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_share/domain/user_actions.dart/i_user_actions_repository.dart';
import 'package:flutter_share/domain/user_actions.dart/user_actions_failure.dart';
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
      fetchProfile: (e) async* {
        yield UserActionsState.loading();
        final failureOrSuccess =
            await _userActionsRepository.fetchProfile(e.userId);
        yield failureOrSuccess.fold(
          (l) => UserActionsState.error(l),
          (r) => UserActionsState.loaded(r),
        );
      },
    );
  }
}
