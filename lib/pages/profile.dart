import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/models/post.dart' as model;
import 'package:flutter_share/pages/post.dart' as wid;
import 'package:flutter_share/pages/edit_profile.dart';
import 'package:flutter_share/widgets/header.dart';
import 'package:flutter_share/pages/home.dart';

class Profile extends StatefulWidget {
  final void Function() logout;
  const Profile(this.logout, {Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var postsCount = 0;
  var posts = <wid.Post>[];
  void editProfile() async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditProfile(logout: widget.logout)));
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getProfilePosts();
  }

  getProfilePosts() async {
    final snap = await postsRef
        .doc(currentUser.id)
        .collection('userPosts')
        .orderBy('timestamp', descending: true)
        .get();
    setState(() {
      postsCount = snap.docs.length;
      posts = snap.docs.map((doc) {
        var post = model.Post.fromDocument(doc);
        return wid.Post(post);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, 'Profile'),
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage:
                    CachedNetworkImageProvider(currentUser.photoUrl),
              ),
              Column(
                children: [
                  Row(
                    // mainAxisSize: MainAxisSize.max,
                    children: [
                      Column(children: [
                        Text(postsCount.toString()),
                        Text('Posts')
                      ]),
                      Column(children: [Text('0'), Text('Followers')]),
                      Column(children: [Text('0'), Text('Following')]),
                    ],
                  ),
                  TextButton(
                      onPressed: editProfile, child: Text('Edit Profile'))
                ],
              ),
            ],
          ),
          Text(currentUser.displayName),
          Text(currentUser.username),
          Column(
            children: posts,
          ),
        ],
      ),
    );
  }
}
