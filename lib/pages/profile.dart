import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/domain/posts/post.dart' as model;
import 'package:flutter_share/models/user.dart';
import 'package:flutter_share/domain/auth/user.dart' as domainUser;
import 'package:flutter_share/presentation/profile/widgets/single_post.dart' as wid;
import 'package:flutter_share/pages/edit_profile.dart';
import 'package:flutter_share/widgets/header.dart';
import 'package:flutter_share/pages/home.dart';
import 'package:flutter_share/widgets/post_tile.dart';

class Profile extends StatefulWidget {
  final String userId;
  const Profile(this.userId, {Key? key}) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int postsCount = 0;
  List<wid.SinglePost> posts = [];
  bool grid = true;
  bool isFollowing = false;
  int followers = 0;
  int following = 0;

  Future<void> editProfile() async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => EditProfile()));
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getProfilePosts();
    getFollowersCount();
    getFollowingCount();
    checkIfFollowing();
  }

  Future<void> getFollowingCount() async {
    final doc =
        await followingRef.doc(widget.userId).collection('following').get();
    setState(() {
      following = doc.size;
    });
  }

  Future<void> getFollowersCount() async {
    final doc =
        await followersRef.doc(widget.userId).collection('followers').get();
    setState(() {
      followers = doc.size;
    });
  }

  Future<void> checkIfFollowing() async {
    final doc = await followingRef
        .doc(currentUser!.id)
        .collection('following')
        .doc(widget.userId)
        .get();
    setState(() {
      isFollowing = doc.exists;
    });
  }

  Future<void> getProfilePosts() async {
    final snap = await postsRef
        .doc(widget.userId)
        .collection('userPosts')
        .orderBy('timestamp', descending: true)
        .get();
    setState(() {
      postsCount = snap.docs.length;
      posts = snap.docs.map((doc) {
        // final post = model.Post.fromJson(doc);
        return wid.SinglePost(
          model.Post.fromJson(
            doc.data(),
          ),
          domainUser.User(
              id: 'id',
              username: 'username',
              email: 'email',
              photoUrl: 'photoUrl',
              displayName: 'displayName',
              bio: 'bio'),
        );
      }).toList();
    });
  }

  Widget buildGrid(BuildContext context) {
    final gridTiles = <GridTile>[];
    // posts.forEach((post) {
    //   gridTiles.add(GridTile(child: postTile(context, post.post)));
    // });
    for (final post in posts) {
      gridTiles.add(GridTile(child: postTile(context, post.post)));
    }
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      mainAxisSpacing: 1.5,
      crossAxisSpacing: 1.5,
      physics: const NeverScrollableScrollPhysics(),
      // childAspectRatio: 1,
      children: gridTiles,
    );
  }

  void gridOn({required bool set}) {
    setState(() {
      grid = set;
    });
  }

  Widget changeOrientation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon: const Icon(Icons.grid_on),
          onPressed: () => gridOn(set: true),
          color: grid ? Colors.pink : null,
        ),
        IconButton(
          icon: const Icon(Icons.list),
          onPressed: () => gridOn(set: false),
          color: !grid ? Colors.pink : null,
        ),
      ],
    );
  }

  void changeFollowStatus() {
    setState(() {
      isFollowing = !isFollowing;
      followers += isFollowing ? 1 : -1;
    });
    if (isFollowing) {
      followingRef
          .doc(currentUser!.id)
          .collection('following')
          .doc(widget.userId)
          .set({});
      followersRef
          .doc(widget.userId)
          .collection('followers')
          .doc(currentUser!.id)
          .set({});
      feedRef.doc(widget.userId).collection('userFeed').add({
        'type': 'follow',
        'timestamp': DateTime.now(),
        'photoUrl': currentUser!.photoUrl,
        'username': currentUser!.username,
        'userId': currentUser!.id,
      });
    } else {
      followingRef
          .doc(currentUser!.id)
          .collection('following')
          .doc(widget.userId)
          .delete();
      followersRef
          .doc(widget.userId)
          .collection('followers')
          .doc(currentUser!.id)
          .delete();
      feedRef
          .doc(widget.userId)
          .collection('userFeed')
          .where('userId', isEqualTo: currentUser!.id)
          .where('type', isEqualTo: 'follow')
          .get()
          .then((value) {
        // value.docs.forEach((doc) {
        //   doc.reference.delete();
        // });
        for (final doc in value.docs) {
          doc.reference.delete();
        }
      });
    }
  }

  Widget buildButtons() {
    return SizedBox(
      height: 25,
      width: 200,
      child: currentUser!.id == widget.userId
          ? OutlinedButton(
              onPressed: editProfile,
              child: const Text('Edit Profile'),
            )
          : OutlinedButton(
              onPressed: changeFollowStatus,
              child:
                  isFollowing ? const Text('Unfollow') : const Text('Follow'),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, 'Profile'),
      body: FutureBuilder<DocumentSnapshot>(
          future: usersRef.doc(widget.userId).get(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Text('');
            final user = User.fromDocument(snapshot.data!);
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
                                  margin: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  child: Row(
                                    // mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(children: [
                                        Text(postsCount.toString()),
                                        const Text('Posts')
                                      ]),
                                      Column(children: [
                                        Text(followers.toString()),
                                        const Text('Followers')
                                      ]),
                                      Column(children: [
                                        Text(following.toString()),
                                        const Text('Following')
                                      ]),
                                    ],
                                  ),
                                ),
                                buildButtons(),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Text(
                          user.username,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          user.displayName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(top: 2.0),
                        child: Text(
                          user.bio,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  height: 0,
                ),
                changeOrientation(),
                const Divider(
                  height: 0,
                ),
                if (grid)
                  buildGrid(context)
                else
                  Column(
                    children: posts,
                  ),
              ],
            );
          }),
    );
  }
}
