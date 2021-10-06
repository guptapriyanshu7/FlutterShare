import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_share/application/user_actions/user_actions_bloc.dart';
import 'package:flutter_share/domain/auth/user.dart';
import 'package:flutter_share/domain/posts/post.dart';
import 'package:flutter_share/injection.dart';
import 'package:flutter_share/presentation/profile/profile_page.dart';

// import 'package:flutter_share/widgets/cached_image.dart';
import 'package:animator/animator.dart';
import 'package:flutter_share/presentation/routes/router.gr.dart';

class SinglePost extends HookWidget {
  final Post post;
  final User user;
  const SinglePost(this.post, this.user, {Key? key}) : super(key: key);

  int getLikesCount(Map<String, dynamic> likes) {
    var count = 0;
    for (final val in likes.values) {
      if (val == true) count += 1;
    }
    return count;
  }

  Widget _buidUsernameAndCaption(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15),
      child: RichText(
        text: TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: [
            TextSpan(
              text: '${user.username} ',
              recognizer: TapGestureRecognizer()
                ..onTap = () => context.pushRoute(
                      ProfileRoute(id: user.id),
                    ),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(text: post.caption),
          ],
        ),
      ),
    );
  }

  Widget _buildLikesCounter() {
    return Container(
      margin: const EdgeInsets.only(left: 15),
      child: Text(
        '${getLikesCount(post.likes)} likes',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: CachedNetworkImageProvider(user.photoUrl),
      ),
      title: GestureDetector(
        onTap: () => context.pushRoute(ProfileRoute(id: user.id)),
        child: Text(user.username),
      ),
      subtitle: Text(post.location),
      trailing: IconButton(
        onPressed: () => print('deleting post'),
        icon: const Icon(Icons.more_vert),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final showHeart = useState(false);
    return BlocProvider(
      create: (context) =>
          getIt<UserActionsBloc>()..add(UserActionsEvent.checkLikeStatus(post)),
      child: BlocBuilder<UserActionsBloc, UserActionsState>(
        builder: (context, state) {
          return state.maybeMap(
            orElse: () => Text(''),
            likeStatus: (status) {
              final isLiked = status.isLiked;
              return Column(
                children: [
                  _buildHeader(context),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      GestureDetector(
                        onDoubleTap: () {
                          context
                              .read<UserActionsBloc>()
                              .add(UserActionsEvent.likePost(!isLiked, post));
                          if (!isLiked) {
                            showHeart.value = true;
                            Timer(const Duration(milliseconds: 500), () {
                              showHeart.value = false;
                            });
                          }
                        },
                        child: cachedImage(post.mediaUrl),
                      ),
                      if (showHeart.value)
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
                              isLiked ? Icons.favorite : Icons.favorite_border,
                            ),
                            onPressed: () => context
                                .read<UserActionsBloc>()
                                .add(UserActionsEvent.likePost(!isLiked, post)),
                            iconSize: 28.0,
                            color: Theme.of(context).accentColor,
                          ),
                          IconButton(
                            icon: const Icon(Icons.chat),
                            onPressed: () {
                              context.pushRoute(CommentsRoute(
                                postId: post.id,
                                postOwner: post.ownerid,
                                photoUrl: post.mediaUrl,
                              ));
                            },
                            iconSize: 28.0,
                            color: Theme.of(context).accentColor,
                          ),
                        ],
                      ),
                      _buildLikesCounter(),
                      _buidUsernameAndCaption(context),
                      const SizedBox(height: 10),
                    ],
                  )
                ],
              );
            },
          );
        },
      ),
    );
  }
}
