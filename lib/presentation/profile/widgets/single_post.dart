import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/domain/auth/i_auth_facade.dart';
import 'package:flutter_share/domain/auth/user.dart';
import 'package:flutter_share/domain/core/errors.dart';
import 'package:flutter_share/domain/posts/post.dart';
import 'package:flutter_share/injection.dart';
import 'package:flutter_share/pages/home.dart';
import 'package:flutter_share/presentation/profile/profile_page.dart';

// import 'package:flutter_share/widgets/cached_image.dart';
import 'package:animator/animator.dart';
import 'package:flutter_share/presentation/routes/router.gr.dart';

class SinglePost extends StatefulWidget {
  final Post post;
  final User user;
  const SinglePost(this.post, this.user, {Key? key}) : super(key: key);

  @override
  _SinglePostState createState() => _SinglePostState();
}

class _SinglePostState extends State<SinglePost> {
  late final User currentUser;
  bool showHeart = false;
  bool isliked = false;

  Future<void> getUser() async {
    final userOption = await getIt<IAuthFacade>().getSignedInUser();
    currentUser = userOption.getOrElse(() => throw NotAuthenticatedError());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser().then((value) {
      isliked = widget.post.likes[currentUser.id] as bool;
    });
  }

  int getLikesCount(Map<String, dynamic> likes) {
    var count = 0;
    for (final val in likes.values) {
      if (val == true) count += 1;
    }
    return count;
  }

  void likesController() async {
    final userOption = await getIt<IAuthFacade>().getSignedInUser();
    final currentUser =
        userOption.getOrElse(() => throw NotAuthenticatedError());
    postsRef
        .doc(widget.post.ownerid)
        .collection('userPosts')
        .doc(widget.post.id)
        .update({'likes.${currentUser.id}': !isliked});
    if (!isliked) {
      feedRef.doc(widget.post.ownerid).collection('userFeed').add({
        'type': 'like',
        'timestamp': DateTime.now(),
        'photoUrl': currentUser.photoUrl,
        'username': currentUser.username,
        'userId': currentUser.id,
        'postId': widget.post.id,
        "mediaUrl": widget.post.mediaUrl,
      });
    } else {
      feedRef
          .doc(widget.post.ownerid)
          .collection('userFeed')
          .where('userId', isEqualTo: currentUser.id)
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
      widget.post.likes[currentUser.id] = isliked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(widget.user.photoUrl),
          ),
          title: GestureDetector(
            onTap: () => context.pushRoute(ProfileRoute(id: widget.user.id)),
            child: Text(widget.user.username),
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
                    context.pushRoute(CommentsRoute(
                      postId: widget.post.id,
                      postOwner: widget.post.ownerid,
                      photoUrl: widget.post.mediaUrl,
                    ));
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
                    TextSpan(
                      text: '${widget.user.username} ',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => context.pushRoute(
                              ProfileRoute(id: widget.user.id),
                            ),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
