import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:flutter_share/domain/auth/auth_failure.dart';
import 'package:flutter_share/domain/auth/i_auth_facade.dart';

part 'sign_in_form_bloc.freezed.dart';
part 'sign_in_form_event.dart';
part 'sign_in_form_state.dart';

@injectable
class SignInFormBloc extends Bloc<SignInFormEvent, SignInFormState> {
  final IAuthFacade _authFacade;

  SignInFormBloc(this._authFacade) : super(SignInFormState.initial()) {
    on<SignInFormEvent>(_onSignInFormEvent);
  }

  Future<void> _onSignInFormEvent(
    SignInFormEvent event,
    Emitter<SignInFormState> emit,
  ) async {
    await event.when(
      emailChanged: (String emailStr) {
        emit(
          state.copyWith(
            emailAddress: emailStr,
            authFailureOrSuccessOption: none(),
          ),
        );
      },
      passwordChanged: (String passwordStr) {
        emit(
          state.copyWith(
            password: passwordStr,
            authFailureOrSuccessOption: none(),
          ),
        );
      },
      registerWithEmailAndPasswordPressed: () async {
        await _chooseRegisterOrSignIn(
          emit,
          _authFacade.registerWithEmailAndPassword,
        );
      },
      signInWithEmailAndPasswordPressed: () async {
        await _chooseRegisterOrSignIn(
          emit,
          _authFacade.signInWithEmailAndPassword,
        );
      },
      signInWithGooglePressed: () async {
        emit(
          state.copyWith(
            isSubmitting: true,
            authFailureOrSuccessOption: none(),
          ),
        );
        final failureOrSuccess = await _authFacade.signInWithGoogle();
        emit(
          state.copyWith(
            isSubmitting: false,
            authFailureOrSuccessOption: some(failureOrSuccess),
          ),
        );
      },
    );
  }

  Future<void> _chooseRegisterOrSignIn(
    Emitter<SignInFormState> emit,
    Future<Either<AuthFailure, Unit>> Function({
      required String emailAddress,
      required String password,
    })
        forwardedCall,
  ) async {
    Either<AuthFailure, Unit>? failureOrSuccess;
    emit(
      state.copyWith(
        isSubmitting: true,
        authFailureOrSuccessOption: none(),
      ),
    );
    failureOrSuccess = await forwardedCall(
      emailAddress: state.emailAddress,
      password: state.password,
    );
    emit(
      state.copyWith(
        showErrorMessages: true,
        isSubmitting: false,
        authFailureOrSuccessOption: optionOf(failureOrSuccess),
      ),
    );
  }
}
