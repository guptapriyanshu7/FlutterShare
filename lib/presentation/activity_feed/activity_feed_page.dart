import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/domain/auth/i_auth_facade.dart';
import 'package:flutter_share/domain/auth/user.dart';
import 'package:flutter_share/domain/core/errors.dart';
import 'package:timeago/timeago.dart';

import 'package:flutter_share/injection.dart';
import 'package:flutter_share/presentation/routes/router.gr.dart';

class ActivityFeedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userOption = getIt<IAuthFacade>().getSignedInUser();
    final currentUser =
        userOption.getOrElse(() => throw NotAuthenticatedError());

    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: FutureBuilder(
        future: getIt<FirebaseFirestore>()
            .collection('feed')
            .doc(currentUser.id)
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
                    currentUser: currentUser,
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
    required this.currentUser,
    Key? key,
  }) : super(key: key);

  final QueryDocumentSnapshot<Object?> doc;
  final User currentUser;

  void _handleRouting(
    QueryDocumentSnapshot<Object?> doc,
    BuildContext context,
    User currentUser,
  ) {
    {
      if (doc['type'] == 'follow') {
        context.pushRoute(
          ProfileRoute(id: doc['userId'] as String),
        );
      } else {
        context.pushRoute(
          SinglePostRoute(
            userId: currentUser.id,
            postId: doc['postId'] as String,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _handleRouting(doc, context, currentUser),
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
