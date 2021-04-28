import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/pages/home.dart';
import 'package:flutter_share/widgets/header.dart';
import 'package:flutter_share/widgets/progress.dart';
import 'package:timeago/timeago.dart';

class CommnetsScreen extends StatefulWidget {
  final String postId;
  CommnetsScreen(this.postId, {Key key}) : super(key: key);

  @override
  _CommnetsScreenState createState() => _CommnetsScreenState();
}

class _CommnetsScreenState extends State<CommnetsScreen> {
  final commentController = TextEditingController();
  Widget showComments() {
    return StreamBuilder(
      stream: commentsRef
          .doc(widget.postId)
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
    commentsRef.doc(widget.postId).collection("comments").add({
      'comment': commentController.text,
      'timestamp': DateTime.now(),
      'userId': currentUser.id,
      'username': currentUser.username,
      'avatar': currentUser.photoUrl,
    });
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
                decoration: InputDecoration(labelText: 'Write  comment...'),
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
