import 'dart:async';

import 'package:animator/animator.dart';
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
import 'package:flutter_share/presentation/routes/router.gr.dart';

class SinglePost extends StatelessWidget {
  final Post post;
  final User user;
  const SinglePost(this.post, this.user, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<UserActionsBloc>()..add(UserActionsEvent.checkLikeStatus(post)),
      child: BlocBuilder<UserActionsBloc, UserActionsState>(
        builder: (context, state) {
          return state.maybeMap(
            orElse: () => const Text(''),
            loading: (_) => const CircularProgressIndicator(),
            error: (_) => const Text('Something bad happened!'),
            likeStatus: (status) {
              final isLiked = status.isLiked;
              return Column(
                children: [
                  _BuildHeader(
                    user: user,
                    post: post,
                  ),
                  _PostImage(
                    post: post,
                    isLiked: isLiked,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _LikeAndCommentIcons(isLiked: isLiked, post: post),
                      _BuildLikesCounter(post: post),
                      _BuildUsernameAndCaption(user: user, post: post),
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

class _LikeAndCommentIcons extends StatelessWidget {
  const _LikeAndCommentIcons({
    Key? key,
    required this.isLiked,
    required this.post,
  }) : super(key: key);

  final bool isLiked;
  final Post post;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(
            isLiked ? Icons.favorite : Icons.favorite_border,
          ),
          onPressed: () => context
              .read<UserActionsBloc>()
              .add(UserActionsEvent.likePost(!isLiked, post)),
          iconSize: 28.0,
          color: Theme.of(context).colorScheme.secondary,
        ),
        IconButton(
          icon: const Icon(Icons.chat),
          onPressed: () {
            context.pushRoute(
              CommentsRoute(
                postId: post.id,
                postOwner: post.ownerid,
                photoUrl: post.mediaUrl,
              ),
            );
          },
          iconSize: 28.0,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ],
    );
  }
}

class _PostImage extends HookWidget {
  const _PostImage({
    Key? key,
    required this.post,
    required this.isLiked,
  }) : super(key: key);

  final Post post;
  final bool isLiked;

  @override
  Widget build(BuildContext context) {
    final showHeart = useState(false);
    return Stack(
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
          child: CachedImage(mediaUrl: post.mediaUrl),
        ),
        if (showHeart.value) const _HeartAnimation() else const Text(''),
      ],
    );
  }
}

class _HeartAnimation extends StatelessWidget {
  const _HeartAnimation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Animator(
      duration: const Duration(milliseconds: 300),
      curve: Curves.elasticOut,
      tween: Tween(begin: 0.8, end: 1.4),
      builder: (context, anim, _) => Transform.scale(
        scale: anim.value! as double,
        child: const Icon(
          Icons.favorite,
          color: Colors.white54,
          size: 100,
        ),
      ),
    );
  }
}

class _BuildLikesCounter extends StatelessWidget {
  const _BuildLikesCounter({
    Key? key,
    required this.post,
  }) : super(key: key);

  final Post post;

  int getLikesCount(Map<String, dynamic> likes) {
    int count = 0;
    for (final val in likes.values) {
      if (val == true) count += 1;
    }
    return count;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15),
      child: Text(
        '${getLikesCount(post.likes)} likes',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _BuildHeader extends StatelessWidget {
  const _BuildHeader({
    Key? key,
    required this.user,
    required this.post,
  }) : super(key: key);

  final User user;
  final Post post;

  @override
  Widget build(BuildContext context) {
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
}

class _BuildUsernameAndCaption extends StatelessWidget {
  const _BuildUsernameAndCaption({
    Key? key,
    required this.user,
    required this.post,
  }) : super(key: key);

  final User user;
  final Post post;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 15,
        right: 15,
      ),
      child: RichText(
        text: TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: [
            TextSpan(
              text: '${user.username} ',
              recognizer: TapGestureRecognizer()
                ..onTap = () => context.pushRoute(ProfileRoute(id: user.id)),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(text: post.caption),
          ],
        ),
      ),
    );
  }
}
