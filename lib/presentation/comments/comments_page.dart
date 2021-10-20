import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_share/application/auth/auth_bloc.dart';
import 'package:flutter_share/application/user_actions/user_actions_bloc.dart';
import 'package:flutter_share/domain/auth/user.dart';
import 'package:flutter_share/domain/core/errors.dart';
import 'package:flutter_share/injection.dart';
import 'package:timeago/timeago.dart';

class CommentsPage extends HookWidget {
  final String postId;
  final String postOwner;
  final String photoUrl;
  const CommentsPage(this.postId, this.postOwner, this.photoUrl, {Key? key})
      : super(key: key);

  void addComment(User currentUser, String comment) {
    getIt<FirebaseFirestore>()
        .collection('comments')
        .doc(postId)
        .collection('comments')
        .add({
      'comment': comment,
      'timestamp': DateTime.now().toIso8601String(),
      'userId': currentUser.id,
      'username': currentUser.username,
      'avatar': currentUser.photoUrl,
    });
    // if (currentUser.id != postOwner) {
    getIt<FirebaseFirestore>()
        .collection('feed')
        .doc(postOwner)
        .collection('userFeed')
        .add({
      'type': 'comment',
      'comment': comment,
      'timestamp': DateTime.now(),
      'photoUrl': currentUser.photoUrl,
      'username': currentUser.username,
      'userId': currentUser.id,
      'postId': postId,
      'mediaUrl': photoUrl,
    });
    // }
  }

  @override
  Widget build(BuildContext context) {
    final commentController = useTextEditingController();
    final _authState = context.read<AuthBloc>().state;
    final currentUser = _authState.maybeMap(
      authenticated: (_) => _.currentUser,
      orElse: () => throw NotAuthenticatedError(),
    );
    return Scaffold(
      appBar: AppBar(title: const Text('Comments')),
      body: Column(
        children: [
          Expanded(child: _ShowComments(postId: postId)),
          const Divider(),
          ListTile(
            title: TextField(
              controller: commentController,
              decoration: const InputDecoration(labelText: 'Write comment...'),
            ),
            trailing: OutlinedButton(
              onPressed: () {
                addComment(currentUser, commentController.text);
                commentController.clear();
              },
              child: const Text(
                'POST',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _ShowComments extends StatelessWidget {
  const _ShowComments({
    Key? key,
    required this.postId,
  }) : super(key: key);

  final String postId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<UserActionsBloc>()..add(UserActionsEvent.fetchComments(postId)),
      child: BlocBuilder<UserActionsBloc, UserActionsState>(
        builder: (_, state) => state.maybeMap(
          orElse: () => const Text(''),
          loading: (_) => const Center(child: CircularProgressIndicator()),
          commentsLoaded: (_) {
            final commentsListTile = _.comment.map<ListTile>((commentDomain) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage:
                      CachedNetworkImageProvider(commentDomain.avatar),
                ),
                title: Text(commentDomain.comment),
                subtitle: Text(format(commentDomain.timestamp)),
              );
            }).toList();
            return ListView(children: commentsListTile);
          },
        ),
      ),
    );
  }
}
