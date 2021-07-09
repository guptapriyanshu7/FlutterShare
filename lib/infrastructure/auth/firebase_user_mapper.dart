import 'package:firebase_auth/firebase_auth.dart' as firebaseUser;
import 'package:flutter_share/domain/auth/user.dart';

extension FirebaseUserDomainX on firebaseUser.User {
  User toDomain() {
    return User(id: uid);
  }
}
