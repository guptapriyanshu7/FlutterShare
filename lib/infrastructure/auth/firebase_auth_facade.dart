import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter_share/injection.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_share/domain/auth/auth_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_share/domain/auth/i_auth_facade.dart';
import 'package:flutter_share/domain/auth/user.dart';
import 'package:flutter_share/infrastructure/auth/firebase_user_mapper.dart';

@LazySingleton(as: IAuthFacade)
class FirebaseAuthFacade implements IAuthFacade {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  FirebaseAuthFacade(
    this._firebaseAuth,
    this._googleSignIn,
  );
  @override
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword({
    required String emailAddress,
    required String password,
  }) async {
    // final emailAddressStr = emailAddress.getOrCrash();
    // final passwordStr = password.getOrCrash();
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      _saveUserDocToDatabase(credential);
      return right(unit);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return left(const AuthFailure.emailAlreadyInUse());
      } else {
        return left(const AuthFailure.serverError());
      }
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword({
    required String emailAddress,
    required String password,
  }) async {
    // final emailAddressStr = emailAddress.getOrCrash();
    // final passwordStr = password.getOrCrash();
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      return right(unit);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        return left(const AuthFailure.invalidEmailAndPasswordCombination());
      } else {
        return left(const AuthFailure.serverError());
      }
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return left(const AuthFailure.cancelledByUser());
      }
      final googleAuthentication = await googleUser.authentication;
      final OAuthCredential authCredential = GoogleAuthProvider.credential(
        accessToken: googleAuthentication.accessToken,
        idToken: googleAuthentication.idToken,
      );
      final credential =
          await _firebaseAuth.signInWithCredential(authCredential);
      final doc = await getIt<FirebaseFirestore>()
          .collection('users')
          .doc(credential.user!.uid)
          .get();
      if (!doc.exists) _saveUserDocToDatabase(credential);
      return right(unit);
    } catch (_) {
      return left(const AuthFailure.serverError());
    }
  }

  Future<void> _saveUserDocToDatabase(UserCredential credential) async {
    final firebaseUser = credential.user;
    final userDomain = firebaseUser?.toDomain();
    final userJson = userDomain?.toJson();
    await getIt<FirebaseFirestore>()
        .collection('users')
        .doc(userDomain!.id)
        .set(userJson!);
  }

  @override
  Future<Option<User>> getSignedInUser() async {
    final firebaseUser = _firebaseAuth.currentUser;
    return optionOf(firebaseUser?.toDomain());
  }

  @override
  Future<void> signOut() => Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);
}
