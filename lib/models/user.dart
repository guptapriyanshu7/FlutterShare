import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String username;
  final String email;
  final String photoUrl;
  String displayName;
  String bio;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.photoUrl,
    required this.displayName,
    required this.bio,
  });

  factory User.fromDocument(DocumentSnapshot doc) {
    return User(
      id: doc.id,
      email: doc['email'] as String,
      username: doc['username'] as String,
      photoUrl: doc['photoUrl'] as String,
      displayName: doc['displayName'] as String,
      bio: doc['bio'] as String,
    );
  }
}
