import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String id;
  final String mediaUrl;
  final String caption;
  final String location;
  final Map<String, bool> likes;

  Post({
    this.id,
    this.mediaUrl,
    this.caption,
    this.location,
    this.likes,
  });

  factory Post.fromDocument(DocumentSnapshot doc) {
    return Post(
      id: doc.id,
      mediaUrl: doc['mediaUrl'],
      caption: doc['caption'],
      location: doc['location'],
      likes: doc['likes'],
    );
  }
}
