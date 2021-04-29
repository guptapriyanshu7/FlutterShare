import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/pages/home.dart';
import 'package:flutter_share/widgets/header.dart';
import 'package:flutter_share/widgets/progress.dart';
import 'package:timeago/timeago.dart';

class CommentsScreen extends StatelessWidget {
  final String postId;
  final String postOwner;
  final String photoUrl;
  CommentsScreen(this.postId, this.postOwner, this.photoUrl, {Key key})
      : super(key: key);

  final commentController = TextEditingController();
  Widget showComments() {
    return StreamBuilder(
      stream: commentsRef
          .doc(postId)
          .collection('comments')
          .orderBy('timestamp', descending: false)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return circularIndicator();
        List<ListTile> comments = snapshot.data.docs.map<ListTile>((doc) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(doc['avatar']),
            ),
            title: Text(doc['comment']),
            subtitle: Text(format(doc['timestamp'].toDate())),
          );
        }).toList();
        return ListView(children: comments);
      },
    );
  }

  void addComment() {
    commentsRef.doc(postId).collection("comments").add({
      'comment': commentController.text,
      'timestamp': DateTime.now(),
      'userId': currentUser.id,
      'username': currentUser.username,
      'avatar': currentUser.photoUrl,
    });
    // if (currentUser.id != postOwner) {
    feedRef.doc(postOwner).collection('userFeed').add({
      'type': 'comment',
      'comment': commentController.text,
      'timestamp': DateTime.now(),
      'photoUrl': currentUser.photoUrl,
      'username': currentUser.username,
      'userId': currentUser.id,
      'postId': postId,
      "mediaUrl": photoUrl,
    });
    // }
    commentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: header(context, 'Comments'),
        body: Column(
          children: [
            Expanded(child: showComments()),
            Divider(),
            ListTile(
              title: TextField(
                controller: commentController,
                decoration: InputDecoration(labelText: 'Write comment...'),
              ),
              trailing: OutlinedButton(
                style: ButtonStyle(
                  side: MaterialStateProperty.all<BorderSide>(
                      BorderSide(color: Colors.red)),
                ),
                onPressed: addComment,
                child: Text('POST'),
              ),
            )
          ],
        ));
  }
}
