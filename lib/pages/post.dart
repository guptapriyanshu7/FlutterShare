import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/domain/posts/post.dart' as model;
import 'package:flutter_share/models/user.dart';
import 'package:flutter_share/pages/comments.dart';
import 'package:flutter_share/pages/home.dart';
import 'package:flutter_share/pages/profile.dart';
import 'package:flutter_share/widgets/cached_image.dart';
import 'package:animator/animator.dart';

class Post extends StatefulWidget {
  final model.Post post;
  const Post(this.post, {Key? key}) : super(key: key);

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  int getLikesCount(Map<String, dynamic> likes) {
    var count = 0;
    // likes.values.forEach((val) {
    //   if (val == true) count += 1;
    // });
    for (final val in likes.values) {
      if (val == true) count += 1;
    }
    return count;
  }

  bool isliked = false;
  void likesController() {
    postsRef
        .doc(widget.post.ownerid)
        .collection('userPosts')
        .doc(widget.post.id)
        .update({'likes.${currentUser!.id}': !isliked});
    if (!isliked) {
      feedRef.doc(widget.post.ownerid).collection('userFeed').add({
        'type': 'like',
        'timestamp': DateTime.now(),
        'photoUrl': currentUser!.photoUrl,
        'username': currentUser!.username,
        'userId': currentUser!.id,
        'postId': widget.post.id,
        "mediaUrl": widget.post.mediaUrl,
      });
    } else {
      feedRef
          .doc(widget.post.ownerid)
          .collection('userFeed')
          .where('userId', isEqualTo: currentUser!.id)
          .where('postId', isEqualTo: widget.post.id)
          .where('type', isEqualTo: 'like')
          .get()
          .then((value) {
        // value.docs.forEach((doc) {
        //   doc.reference.delete();
        // });
        for (final doc in value.docs) {
          doc.reference.delete();
        }
      });
    }
    setState(() {
      isliked = !isliked;
      widget.post.likes[currentUser!.id] = isliked;
    });
  }

  bool showHeart = false;

  @override
  Widget build(BuildContext context) {
    // isliked = widget.post.likes[currentUser!.id] as bool;
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
              // backgroundImage: CachedNetworkImageProvider(user.photoUrl),
              ),
          title: GestureDetector(
              // onTap: () => Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => Profile(user.id),
              //       ),
              //     ),
              // child: Text(user.username),
              ),
          subtitle: Text(widget.post.location),
          trailing: IconButton(
            onPressed: () => print('deleting post'),
            icon: const Icon(Icons.more_vert),
          ),
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            GestureDetector(
              onDoubleTap: () {
                likesController();
                if (isliked) {
                  setState(() {
                    showHeart = true;
                  });
                  Timer(const Duration(milliseconds: 500), () {
                    setState(() {
                      showHeart = false;
                    });
                  });
                }
              },
              child: cachedImage(widget.post.mediaUrl),
            ),
            if (showHeart)
              Animator(
                duration: const Duration(milliseconds: 300),
                curve: Curves.elasticOut,
                tween: Tween(begin: 0.8, end: 1.4),
                builder: (context, anim, _) => Transform.scale(
                  scale: anim.value as double,
                  child: const Icon(
                    Icons.favorite,
                    color: Colors.white54,
                    size: 100,
                  ),
                ),
              )
            else
              const Text(''),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    isliked ? Icons.favorite : Icons.favorite_border,
                  ),
                  onPressed: likesController,
                  iconSize: 28.0,
                  color: Theme.of(context).accentColor,
                ),
                IconButton(
                  icon: const Icon(Icons.chat),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CommentsScreen(widget.post.id!,
                            widget.post.ownerid, widget.post.mediaUrl),
                      ),
                    );
                  },
                  iconSize: 28.0,
                  color: Theme.of(context).accentColor,
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(left: 15),
              child: Text(
                '${getLikesCount(widget.post.likes)} likes',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 15, right: 15),
              child: RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: [
                    // TextSpan(
                    //   text: '${user.username} ',
                    //   recognizer: TapGestureRecognizer()
                    //     // ..onTap = () => Navigator.push(
                    //     //       context,
                    //     //       MaterialPageRoute(
                    //     //         builder: (context) => Profile(user.id),
                    //     //       ),
                    //     //     ),
                    //   style: const TextStyle(
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                    TextSpan(text: widget.post.caption),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        )
      ],
    );
  }
}
