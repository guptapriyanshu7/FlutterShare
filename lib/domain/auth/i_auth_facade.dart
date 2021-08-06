import 'package:dartz/dartz.dart';
import 'package:flutter_share/domain/auth/auth_failure.dart';
import 'package:flutter_share/domain/auth/user.dart';

abstract class IAuthFacade {
  Option<User> getSignedInUser();
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword({
    required String emailAddress,
    required String password,
  });
  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword({
    required String emailAddress,
    required String password,
  });
  Future<Either<AuthFailure, Unit>> signInWithGoogle();
  Future<void> signOut();
}
