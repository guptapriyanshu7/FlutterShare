import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_actions_event.dart';
part 'user_actions_state.dart';
part 'user_actions_bloc.freezed.dart';

class UserActionsBloc extends Bloc<UserActionsEvent, UserActionsState> {
  UserActionsBloc() : super(_Initial());

  @override
  Stream<UserActionsState> mapEventToState(
    UserActionsEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
