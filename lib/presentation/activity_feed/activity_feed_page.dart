import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/domain/auth/i_auth_facade.dart';
import 'package:flutter_share/domain/auth/user.dart';
import 'package:flutter_share/domain/core/errors.dart';
import 'package:flutter_share/injection.dart';
import 'package:flutter_share/pages/home.dart';
import 'package:flutter_share/pages/profile.dart';
import 'package:flutter_share/widgets/header.dart';
import 'package:flutter_share/widgets/progress.dart';
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
      appBar: header(context, 'Notifications'),
      body: FutureBuilder(
        future: feedRef
            .doc(currentUser.id)
            .collection('userFeed')
            .orderBy('timestamp', descending: true)
            .limit(50)
            .get(),
        builder: (context, AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
          if (!snapshot.hasData) return circularIndicator();
          return ListView(
            children: snapshot.data?.docs.map<GestureDetector>(
              (doc) {
                return GestureDetector(
                  onTap: () async {
                    if (doc['type'] == 'follow') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return Profile(doc['userId'] as String);
                          },
                        ),
                      );
                    } else {
                      // final post = await postsRef
                      //     .doc(currentUser!.id)
                      //     .collection('userPosts')
                      //     .doc(doc['postId'] as String)
                      //     .get();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return Scaffold(
                              appBar: header(context, 'FlutterShare'),
                              body: SingleChildScrollView(
                                  // child: Post(model.Post.(post)),
                                  ),
                            );
                          },
                        ),
                      );
                    }
                  },
                  child: ListTile(
                    leading: GestureDetector(
                      onTap: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return Profile(doc['userId'] as String);
                            },
                          ),
                        );
                      },
                      child: CircleAvatar(
                        backgroundImage: CachedNetworkImageProvider(
                            doc['photoUrl'] as String),
                      ),
                    ),
                    title: Row(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return Profile(doc['userId'] as String);
                                },
                              ),
                            );
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
