import 'package:bloc/bloc.dart';
import 'package:flutter_share/domain/core/errors.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:flutter_share/domain/auth/i_auth_facade.dart';
import 'package:flutter_share/domain/auth/user.dart';

part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthFacade _authFacade;
  AuthBloc(this._authFacade) : super(const AuthState.initial()) {
    on<AuthEvent>(_onAuthEvent);
  }

  Future<void> _onAuthEvent(AuthEvent event, Emitter<AuthState> emit) async {
    await event.when(
      authCheckRequested: () async {
        final userOption = await _authFacade.getSignedInUser();

        userOption.fold(
          () => emit(const AuthState.unauthenticated()),
          (currentUser) => emit(AuthState.authenticated(currentUser)),
        );
      },
      signedOut: () async {
        final userOption = await _authFacade.getSignedInUser();
        final currentUser =
            userOption.getOrElse(() => throw NotAuthenticatedError());

        await _authFacade.signOut(currentUser);
        emit(const AuthState.unauthenticated());
      },
    );
  }
}
