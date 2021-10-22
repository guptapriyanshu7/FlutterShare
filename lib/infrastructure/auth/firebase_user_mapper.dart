import 'package:firebase_auth/firebase_auth.dart' as firebase_user;
import 'package:flutter_share/domain/auth/user.dart';

extension FirebaseUserDomainX on firebase_user.User {
  User toDomain() {
    return User(
      id: uid,
      bio: '',
      displayName: displayName ?? email!.split('@')[0],
      email: email!,
      photoUrl: photoURL ?? 'https://bit.ly/3yyK8ti',
      username: email!.split('@')[0],
    );
  }
}
