import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/presentation/post/posts_page.dart';

const photoUrl =
    'https://firebasestorage.googleapis.com/v0/b/flutter-share-d228b.appspot.com/o/post_173f6a52-fe2e-4ca0-af33-fe81a5abc1ad.jpg?alt=media&token=90df9b6d-288a-4471-9967-4940b7c827ae';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool grid = true;

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

  Widget _buildGrid(BuildContext context) {
    final gridTiles = <GridTile>[];
    // posts.forEach((post) {
    //   gridTiles.add(GridTile(child: postTile(context, post.post)));
    // });
    // for (final post in posts) {
    //   gridTiles.add(GridTile(child: postTile(context, post.post)));
    // }
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

  Widget buildButtons() {
    return SizedBox(
        height: 25,
        width: 200,
        child:

            // currentUser!.id == widget.userId
            //     ?

            OutlinedButton(
          // onPressed: editProfile,
          onPressed: null,
          child: const Text('Edit Profile'),
        )
        // : OutlinedButton(
        //     // onPressed: changeFollowStatus,
        //     onPressed: null,
        //     child:
        //         isFollowing ? const Text('Unfollow') : const Text('Follow'),
        //   ),
        );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: CachedNetworkImageProvider(photoUrl),
        ),
        Expanded(
          // flex: 1,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  // mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(children: [
                      // Text(postsCount.toString()),
                      Text('1'),
                      const Text('Posts')
                    ]),
                    Column(children: [
                      // Text(followers.toString()),
                      Text('20'),
                      const Text('Followers')
                    ]),
                    Column(children: [
                      // Text(following.toString()),
                      Text('12'),
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
    );
  }

  Widget _buildInfo() {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(top: 12.0),
          child: Text(
            // user.username,
            'guptapriyanshu7',
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
            // user.displayName,
            'Priyanshu Gupta',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(top: 2.0),
          child: Text(
              // user.bio,
              'Bio!'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              _buildHeader(),
              _buildInfo(),
            ],
          ),
        ),
        const Divider(height: 0),
        changeOrientation(),
        const Divider(height: 0),
        if (grid) _buildGrid(context) else PostsPage(),
      ],
    );
  }
}
