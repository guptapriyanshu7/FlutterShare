import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/pages/home.dart';
import 'package:flutter_share/pages/post.dart';
import 'package:flutter_share/models/post.dart' as model;
import 'package:flutter_share/pages/profile.dart';
import 'package:flutter_share/widgets/header.dart';
import 'package:flutter_share/widgets/progress.dart';
import 'package:timeago/timeago.dart';

class ActivityFeed extends StatefulWidget {
  // const ActivityFeed({Key key}) : super(key: key);
  @override
  _ActivityFeedState createState() => _ActivityFeedState();
}

class _ActivityFeedState extends State<ActivityFeed>
    with AutomaticKeepAliveClientMixin {
  get wantKeepAlive => true;

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
          builder: (context, snapshot) {
            if (!snapshot.hasData) return circularIndicator();
            return ListView(
              children: snapshot.data.docs.map<GestureDetector>((doc) {
                return GestureDetector(
                  onTap: () async {
                    if (doc['type'] == 'follow') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return Profile(doc['userId']);
                          },
                        ),
                      );
                    } else {
                      final post = await postsRef
                          .doc(currentUser.id)
                          .collection('userPosts')
                          .doc(doc['postId'])
                          .get();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return Scaffold(
                              appBar: header(context, 'FlutterShare'),
                              body: SingleChildScrollView(
                                child: Post(model.Post.fromDocument(post)),
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
                              return Profile(doc['userId']);
                            },
                          ),
                        );
                      },
                      child: CircleAvatar(
                          backgroundImage:
                              CachedNetworkImageProvider(doc['photoUrl'])),
                    ),
                    title: Row(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return Profile(doc['userId']);
                                },
                              ),
                            );
                          },
                          child: Text(
                            doc['username'],
                            style: TextStyle(fontWeight: FontWeight.bold),
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
                      format(doc['timestamp'].toDate()),
                    ),
                    trailing: doc['type'] == 'follow'
                        ? null
                        : CircleAvatar(
                            backgroundImage:
                                CachedNetworkImageProvider(doc['mediaUrl']),
                          ),
                  ),
                );
              }).toList(),
            );
          }),
    );
  }
}
