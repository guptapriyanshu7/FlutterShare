import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/models/post.dart' as model;
import 'package:flutter_share/models/user.dart';
import 'package:flutter_share/pages/home.dart';
import 'package:flutter_share/widgets/cachedImage.dart';
import 'package:animator/animator.dart';

class Post extends StatefulWidget {
  final model.Post post;
  const Post(this.post, {Key key}) : super(key: key);

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  int getLikesCount(Map<String, dynamic> likes) {
    // if(likes == null) {
    //   return 0;
    // }
    var count = 0;
    likes.values.forEach((val) {
      if (val == true) count += 1;
    });
    return count;
  }

  bool isliked;
  void likesController() {
    postsRef
        .doc(widget.post.ownerid)
        .collection('userPosts')
        .doc(widget.post.id)
        .update({'likes.${currentUser.id}': !isliked});
    setState(() {
      isliked = !isliked;
      widget.post.likes[currentUser.id] = isliked;
    });
  }

  var showHeart = false;

  @override
  Widget build(BuildContext context) {
    isliked = widget.post.likes[currentUser.id];
    if (isliked == null) isliked = false;
    return FutureBuilder(
      future: usersRef.doc(widget.post.ownerid).get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Text('');
        }
        final user = User.fromDocument(snapshot.data);
        return Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(user.photoUrl),
              ),
              title: Text(user.username),
              subtitle: Text(widget.post.location),
              trailing: IconButton(
                onPressed: () => print('deleting post'),
                icon: Icon(Icons.more_vert),
              ),
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                GestureDetector(
                  child: cachedImage(widget.post.mediaUrl),
                  onDoubleTap: () {
                    likesController();
                    if (isliked) {
                      setState(() {
                        showHeart = true;
                      });
                      Timer(Duration(milliseconds: 500), () {
                        setState(() {
                          showHeart = false;
                        });
                      });
                    }
                  },
                ),
                showHeart
                    ? Animator(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.elasticOut,
                        tween: Tween(begin: 0.8, end: 1.4),
                        builder: (context, anim, _) => Transform.scale(
                          scale: anim.value,
                          child: Icon(
                            Icons.favorite,
                            color: Colors.white54,
                            size: 100,
                          ),
                        ),
                      )
                    : Text(''),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                          isliked ? Icons.favorite : Icons.favorite_border),
                      onPressed: likesController,
                      iconSize: 28.0,
                      color: Theme.of(context).accentColor,
                    ),
                    IconButton(
                      icon: Icon(Icons.chat),
                      onPressed: () => print('Comment'),
                      iconSize: 28.0,
                      color: Theme.of(context).accentColor,
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(left: 15),
                  child: Text(
                    getLikesCount(widget.post.likes).toString() + ' likes',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      child: Text(
                        user.username + ' ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(child: Text(widget.post.caption))
                  ],
                ),
                SizedBox(
                  height: 20,
                )
              ],
            )
          ],
        );
      },
    );
  }
}
