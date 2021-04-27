import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String id;
  final String ownerid;
  final String mediaUrl;
  final String caption;
  final String location;
  final Map<String, dynamic> likes;

  Post({
    this.id,
    this.ownerid,
    this.mediaUrl,
    this.caption,
    this.location,
    this.likes,
  });

  factory Post.fromDocument(DocumentSnapshot doc) {
    return Post(
      id: doc.id,
      ownerid: doc['ownerid'],
      mediaUrl: doc['mediaUrl'],
      caption: doc['caption'],
      location: doc['location'],
      likes: doc['likes'],
    );
  }
}
