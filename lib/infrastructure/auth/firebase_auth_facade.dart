import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

import 'package:flutter_share/domain/auth/auth_failure.dart';
import 'package:flutter_share/domain/auth/i_auth_facade.dart';
import 'package:flutter_share/domain/auth/user.dart';
import 'package:flutter_share/infrastructure/auth/firebase_user_mapper.dart';
import 'package:flutter_share/infrastructure/core/firebase_helpers.dart';

@LazySingleton(as: IAuthFacade)
class FirebaseAuthFacade implements IAuthFacade {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  final GoogleSignIn _googleSignIn;
  final FirebaseMessaging _firebaseMessaging;
  FirebaseAuthFacade(
    this._firebaseAuth,
    this._firestore,
    this._googleSignIn,
    this._firebaseMessaging,
  );

  @override
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword({
    required String emailAddress,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      await _saveUserDocToDatabase(credential);
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
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      await _saveUserDocToDatabase(credential);
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
      final authCredential = GoogleAuthProvider.credential(
        accessToken: googleAuthentication.accessToken,
        idToken: googleAuthentication.idToken,
      );
      final credential =
          await _firebaseAuth.signInWithCredential(authCredential);
      await _saveUserDocToDatabase(credential);
      return right(unit);
    } catch (_) {
      return left(const AuthFailure.serverError());
    }
  }

  Future<void> _saveUserDocToDatabase(UserCredential credential) async {
    final firebaseUser = credential.user!;
    final userDomain = firebaseUser.toDomain();
    Map<String, dynamic> userJson = userDomain.toJson();

    final doc = await _firestore.usersCollection.doc(firebaseUser.uid).get();
    if (doc.exists) userJson = doc.data()!;

    final token = await _firebaseMessaging.getToken();
    final updatedUserJson = {...userJson, 'androidNotificationToken': token};

    await _firestore.usersCollection.doc(userDomain.id).set(updatedUserJson);
  }

  @override
  Future<Option<User>> getSignedInUser() async {
    final firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser == null) return none();
    final doc = await _firestore.usersCollection.doc(firebaseUser.uid).get();
    final user = User.fromJson(doc.data()!);
    // return optionOf(firebaseUser?.toDomain());
    return some(user);
  }

  @override
  Future<void> signOut(User currentUser) async {
    final userJson = currentUser.toJson();
    userJson.remove('androidNotificationToken');
    await _firestore.usersCollection.doc(currentUser.id).set(userJson);
    await _firebaseAuth.signOut();
    await _googleSignIn.signOut();
  }
}
