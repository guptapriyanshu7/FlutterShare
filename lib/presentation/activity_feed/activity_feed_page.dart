import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_share/application/auth/auth_bloc.dart';
import 'package:flutter_share/injection.dart';
import 'package:flutter_share/presentation/routes/router.gr.dart';
import 'package:timeago/timeago.dart';

class ActivityFeedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notifications')),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return state.maybeMap(
            orElse: () => CircularProgressIndicator(),
            authenticated: (_) {
              final currentUser = _.currentUser;
              return FutureBuilder(
                future: getIt<FirebaseFirestore>()
                    .collection('feed')
                    .doc(currentUser.id)
                    .collection('userFeed')
                    .orderBy('timestamp', descending: true)
                    .limit(50)
                    .get(),
                builder:
                    (context, AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
                  if (!snapshot.hasData)
                    return Center(child: CircularProgressIndicator());
                  return ListView(
                    children: snapshot.data?.docs.map<GestureDetector>(
                      (doc) {
                        return GestureDetector(
                          onTap: () async {
                            if (doc['type'] == 'follow') {
                              context.pushRoute(
                                  ProfileRoute(id: doc['userId'] as String));
                            } else {
                              context.pushRoute(
                                SinglePostRoute(
                                  userId: currentUser.id,
                                  postId: doc['postId'] as String,
                                ),
                              );
                            }
                          },
                          child: ListTile(
                            leading: GestureDetector(
                              onTap: () async {
                                context.pushRoute(
                                    ProfileRoute(id: doc['userId'] as String));
                              },
                              child: CircleAvatar(
                                backgroundImage: CachedNetworkImageProvider(
                                  doc['photoUrl'] as String,
                                ),
                              ),
                            ),
                            title: Row(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    context.pushRoute(ProfileRoute(
                                        id: doc['userId'] as String));
                                  },
                                  child: Text(
                                    doc['username'] as String,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    doc['type'] == 'comment'
                                        ? ' replied: ${doc['comment']}'
                                        : doc['type'] == 'like'
                                            ? ' liked your post.'
                                            : ' started following you.',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            subtitle: Text(
                              format(doc['timestamp'].toDate() as DateTime),
                            ),
                            trailing: doc['type'] == 'follow'
                                ? null
                                : CircleAvatar(
                                    backgroundImage: CachedNetworkImageProvider(
                                        doc['mediaUrl'] as String),
                                  ),
                          ),
                        );
                      },
                    ).toList() as List<GestureDetector>,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
