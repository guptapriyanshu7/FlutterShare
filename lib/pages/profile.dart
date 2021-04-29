import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/models/post.dart' as model;
import 'package:flutter_share/pages/post.dart' as wid;
import 'package:flutter_share/pages/edit_profile.dart';
import 'package:flutter_share/widgets/header.dart';
import 'package:flutter_share/pages/home.dart';
import 'package:flutter_share/widgets/post_tile.dart';

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

  Widget buildGrid() {
    final gridTiles = <GridTile>[];
    posts.forEach((post) {
      gridTiles.add(GridTile(child: PostTile(post.post)));
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
      body: ListView(
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
                          CachedNetworkImageProvider(currentUser.photoUrl),
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(children: [
                                  Text(postsCount.toString()),
                                  Text('Posts')
                                ]),
                                Column(
                                    children: [Text('0'), Text('Followers')]),
                                Column(
                                    children: [Text('0'), Text('Following')]),
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
                    currentUser.username,
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
                    currentUser.displayName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top: 2.0),
                  child: Text(
                    currentUser.bio,
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
              ? buildGrid()
              : Column(
                  children: posts,
                ),
        ],
      ),
    );
  }
}
