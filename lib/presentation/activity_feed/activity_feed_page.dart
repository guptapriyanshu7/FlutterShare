import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/domain/auth/i_auth_facade.dart';
import 'package:flutter_share/domain/auth/user.dart';
import 'package:flutter_share/domain/core/errors.dart';
import 'package:flutter_share/domain/posts/post.dart';
// import 'package:flutter_share/domain/posts/post.dart';
import 'package:flutter_share/injection.dart';
import 'package:flutter_share/presentation/routes/router.gr.dart';
import 'package:timeago/timeago.dart';
// import 'package:dartz/dartz.dart' hide State;

class ActivityFeedPage extends StatefulWidget {
  // const ActivityFeedPage({Key key}) : super(key: key);
  @override
  _ActivityFeedPageState createState() => _ActivityFeedPageState();
}

class _ActivityFeedPageState extends State<ActivityFeedPage>
    with AutomaticKeepAliveClientMixin {
  late User currentUser;
  @override
  bool get wantKeepAlive => true;

  Future<void> getUser() async {
    final userOption = await getIt<IAuthFacade>().getSignedInUser();
    currentUser = userOption.getOrElse(() => throw NotAuthenticatedError());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(title: Text('Notifications')),
      body: FutureBuilder(
        future: getIt<FirebaseFirestore>()
            .collection('feed')
            .doc(currentUser.id)
            .collection('userFeed')
            .orderBy('timestamp', descending: true)
            .limit(50)
            .get(),
        builder: (context, AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();
          return ListView(
            children: snapshot.data?.docs.map<GestureDetector>(
              (doc) {
                return GestureDetector(
                  onTap: () async {
                    if (doc['type'] == 'follow') {
                      context
                          .pushRoute(ProfileRoute(id: doc['userId'] as String));
                    } else {
                      final postDoc = await getIt<FirebaseFirestore>()
                          .collection('posts')
                          .doc(currentUser.id)
                          .collection('userPosts')
                          .doc(doc['postId'] as String)
                          .get();
                      final postJson = postDoc.data();
                      final post = Post.fromJson(postJson!);
                      final userDoc = await getIt<FirebaseFirestore>()
                          .collection('users')
                          .doc(post.ownerid)
                          .get();
                      final userJson = userDoc.data();
                      final user = User.fromJson(userJson!);
                      context.pushRoute(
                          SinglePostRoute(id: post.id, post: post, user: user));
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
                            context.pushRoute(
                                ProfileRoute(id: doc['userId'] as String));
                          },
                          child: Text(
                            doc['username'] as String,
                            style: const TextStyle(fontWeight: FontWeight.bold),
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
      ),
    );
  }
}
