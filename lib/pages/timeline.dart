import 'package:flutter/material.dart';
import 'package:flutter_share/widgets/header.dart';
import 'package:flutter_share/widgets/progress.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final usersRef = FirebaseFirestore.instance.collection('users');

class Timeline extends StatelessWidget {
  const Timeline({Key key}) : super(key: key);

  // void getUsers() async {
  //   final snapshot = await usersRef
  //       .where('postsCount', isGreaterThan: 2)
  //       // .where('isAdmin', isEqualTo: true)
  //       .where('username', isEqualTo: 'priyanshu')
  //       // .orderBy('postsCount', descending: true)
  //       // .limit(1)
  //       .get();
  //   snapshot.docs.forEach((doc) {
  //     print(doc.data());
  //     print(doc.id);
  //     print(doc.exists);
  //   });
  // }

  // void getUserById() async {
  //   final String id = 'wC74lTFNybUOYLVvyyvS';
  //   final doc = await usersRef.doc(id).get();
  //   print(doc.data());
  //   print(doc.id);
  //   print(doc.exists);
  // }

  @override
  Widget build(BuildContext context) {
    // getUsers();
    return Scaffold(
      appBar: header(context, 'FlutterShare'),
      body: StreamBuilder(
        stream: usersRef.snapshots(),
        builder: (ctx, snapshot) {
          if (!snapshot.hasData) {
            return circularIndicator();
          }
          final List<Text> children = snapshot.data.docs
              .map<Text>((doc) => Text(doc['username']))
              .toList();
          return Container(
            child: ListView(children: children),
          );
        },
      ),
    );
  }
}
