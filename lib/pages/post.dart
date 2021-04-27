import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/models/post.dart' as model;
import 'package:flutter_share/models/user.dart';
import 'package:flutter_share/pages/home.dart';
import 'package:flutter_share/widgets/progress.dart';

class Post extends StatelessWidget {
  final model.Post post;
  const Post(this.post, {Key key}) : super(key: key);
  int getLikesCount(Map<String, bool> likes) {
    // if(likes == null) {
    //   return 0;
    // }
    var count = 0;
    likes.values.forEach((val) {
      if (val == true) count += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder(
          future: usersRef.doc(post.ownerid).get(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return circularIndicator();
            }
            final user = User.fromDocument(snapshot.data);
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(user.photoUrl),
              ),
              title: Text(user.username),
              subtitle: Text(post.location),
              trailing: IconButton(
                onPressed: () => print('deleting post'),
                icon: Icon(Icons.more_vert),
              ),
            );
          },
        ),
      ],
    );
  }
}
