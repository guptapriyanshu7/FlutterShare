import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/pages/home.dart';
import 'package:flutter_share/widgets/header.dart';
import 'package:flutter_share/widgets/progress.dart';
import 'package:timeago/timeago.dart';

class ActivityFeed extends StatelessWidget {
  const ActivityFeed({Key key}) : super(key: key);

  void buildNotif() {}

  @override
  Widget build(BuildContext context) {
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
              children: snapshot.data.docs.map<ListTile>((doc) {
                return ListTile(
                  leading: CircleAvatar(
                      backgroundImage:
                          CachedNetworkImageProvider(doc['photoUrl'])),
                  title: Row(
                    children: [
                      Text(
                        doc['username'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Flexible(
                        child: Text(
                          doc['type'] == 'comment' ? ' replied: ${doc['comment']}' : ' liked your post.',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  subtitle: Text(
                    format(doc['timestamp'].toDate()),
                  ),
                  trailing: CircleAvatar(
                    backgroundImage:
                        CachedNetworkImageProvider(doc['mediaUrl']),
                  ),
                );
              }).toList(),
            );
          }),
    );
  }
}
