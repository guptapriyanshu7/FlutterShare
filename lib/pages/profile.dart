import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/models/post.dart' as model;
import 'package:flutter_share/models/user.dart';
import 'package:flutter_share/pages/post.dart' as wid;
import 'package:flutter_share/pages/edit_profile.dart';
import 'package:flutter_share/widgets/header.dart';
import 'package:flutter_share/pages/home.dart';
import 'package:flutter_share/widgets/post_tile.dart';

class Profile extends StatefulWidget {
  final String userId;
  const Profile(this.userId, {Key key}) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var postsCount = 0;
  var posts = <wid.Post>[];

  void editProfile() async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => EditProfile()));
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getProfilePosts();
  }

  getProfilePosts() async {
    final snap = await postsRef
        .doc(widget.userId)
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

  Widget buildGrid(BuildContext context) {
    final gridTiles = <GridTile>[];
    posts.forEach((post) {
      gridTiles.add(GridTile(child: postTile(context, post.post)));
    });
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      mainAxisSpacing: 1.5,
      crossAxisSpacing: 1.5,
      // childAspectRatio: 1,
      children: gridTiles,
      physics: NeverScrollableScrollPhysics(),
    );
  }

  var grid = true;
  void gridOn(bool set) {
    setState(() {
      grid = set;
    });
  }

  Widget changeOrientation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon: Icon(Icons.grid_on),
          onPressed: () => gridOn(true),
          color: grid ? Colors.pink : null,
        ),
        IconButton(
          icon: Icon(Icons.list),
          onPressed: () => gridOn(false),
          color: !grid ? Colors.pink : null,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, 'Profile'),
      body: FutureBuilder<DocumentSnapshot>(
          future: usersRef.doc(widget.userId).get(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Text('');
            final user = User.fromDocument(snapshot.data);
            return ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage:
                                CachedNetworkImageProvider(user.photoUrl),
                          ),
                          Expanded(
                            // flex: 1,
                            child: Column(
                              // crossAxisAlignment: CrossAxisAlignment.stretch,
                              // mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 10, bottom: 10),
                                  child: Row(
                                    // mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(children: [
                                        Text(postsCount.toString()),
                                        Text('Posts')
                                      ]),
                                      Column(children: [
                                        Text('0'),
                                        Text('Followers')
                                      ]),
                                      Column(children: [
                                        Text('0'),
                                        Text('Following')
                                      ]),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 25,
                                  child: OutlinedButton(
                                    onPressed: editProfile,
                                    child: Text('Edit Profile'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(top: 12.0),
                        child: Text(
                          user.username,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(top: 4.0),
                        child: Text(
                          user.displayName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(top: 2.0),
                        child: Text(
                          user.bio,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 0,
                ),
                changeOrientation(),
                Divider(
                  height: 0,
                ),
                grid
                    ? buildGrid(context)
                    : Column(
                        children: posts,
                      ),
              ],
            );
          }),
    );
  }
}
