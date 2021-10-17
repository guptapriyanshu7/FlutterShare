import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/application/auth/auth_bloc.dart';
import 'package:flutter_share/domain/core/errors.dart';
import 'package:timeago/timeago.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_share/injection.dart';
import 'package:flutter_share/presentation/routes/router.gr.dart';

class ActivityFeedPage extends StatelessWidget {
  const ActivityFeedPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _authState = context.read<AuthBloc>().state;
    final currentUserId = _authState.maybeMap(
      authenticated: (_) => _.currentUser.id,
      orElse: () => throw NotAuthenticatedError(),
    );
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: FutureBuilder(
        future: getIt<FirebaseFirestore>()
            .collection('feed')
            .doc(currentUserId)
            .collection('userFeed')
            .orderBy('timestamp', descending: true)
            .limit(50)
            .get(),
        builder: (context, AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView(
            children: snapshot.data!.docs
                .map(
                  (doc) => _OpenProfileOrPost(
                    doc: doc,
                    currentUserId: currentUserId,
                  ),
                )
                .toList(),
          );
        },
      ),
    );
  }
}

class _OpenProfileOrPost extends StatelessWidget {
  const _OpenProfileOrPost({
    required this.doc,
    required this.currentUserId,
    Key? key,
  }) : super(key: key);

  final QueryDocumentSnapshot<Object?> doc;
  final String currentUserId;

  void _handleRouting(
    QueryDocumentSnapshot<Object?> doc,
    BuildContext context,
    String currentUserId,
  ) {
    {
      if (doc['type'] == 'follow') {
        context.pushRoute(
          ProfileRoute(id: doc['userId'] as String),
        );
      } else {
        context.pushRoute(
          SinglePostRoute(
            userId: currentUserId,
            postId: doc['postId'] as String,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _handleRouting(doc, context, currentUserId),
      child: ListTile(
        leading: _OpenProfileByAvatar(doc: doc),
        title: Row(
          children: [
            _OpenProfileByUsername(doc: doc),
            _DisplayText(doc: doc),
          ],
        ),
        subtitle: Text(
          format(doc['timestamp'].toDate() as DateTime),
        ),
        trailing: doc['type'] == 'follow'
            ? null
            : CircleAvatar(
                backgroundImage:
                    CachedNetworkImageProvider(doc['mediaUrl'] as String),
              ),
      ),
    );
  }
}

class _DisplayText extends StatelessWidget {
  const _DisplayText({
    required this.doc,
    Key? key,
  }) : super(key: key);

  final QueryDocumentSnapshot<Object?> doc;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Text(
        doc['type'] == 'comment'
            ? ' replied: ${doc['comment']}'
            : doc['type'] == 'like'
                ? ' liked your post.'
                : ' started following you.',
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class _OpenProfileByUsername extends StatelessWidget {
  const _OpenProfileByUsername({
    required this.doc,
    Key? key,
  }) : super(key: key);

  final QueryDocumentSnapshot<Object?> doc;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pushRoute(
        ProfileRoute(id: doc['userId'] as String),
      ),
      child: Text(
        doc['username'] as String,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _OpenProfileByAvatar extends StatelessWidget {
  const _OpenProfileByAvatar({
    required this.doc,
    Key? key,
  }) : super(key: key);

  final QueryDocumentSnapshot<Object?> doc;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pushRoute(
        ProfileRoute(id: doc['userId'] as String),
      ),
      child: CircleAvatar(
        backgroundImage: CachedNetworkImageProvider(
          doc['photoUrl'] as String,
        ),
      ),
    );
  }
}
