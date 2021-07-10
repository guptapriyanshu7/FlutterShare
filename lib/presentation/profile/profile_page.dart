import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_share/application/user_actions/user_actions_bloc.dart';
import 'package:flutter_share/domain/auth/user.dart';
import 'package:flutter_share/domain/posts/post.dart';
import 'package:flutter_share/injection.dart';
import 'package:flutter_share/presentation/profile/single_post.dart';
// import 'package:flutter_share/presentation/post/posts_page.dart';

Widget cachedImage(String mediaUrl) {
  print(mediaUrl);
  return CachedNetworkImage(
    imageUrl: mediaUrl,
    fit: BoxFit.cover,
    placeholder: (context, url) => const Padding(
      padding: EdgeInsets.all(30),
      child: CircularProgressIndicator(),
    ),
    errorWidget: (context, url, error) => const Icon(Icons.error),
  );
}

class ProfilePage extends HookWidget {
  ProfilePage(String id, {Key? key}) : super(key: key);
  late User user;
  late List<Post> posts;
  late int following;
  late int followers;
  // final grid = true;

  void gridOn({required bool set}) {
    // setState(() {
    // grid = set;
    // });
  }

  Widget postTile(BuildContext context, Post post) {
    return GestureDetector(
      onTap: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return Scaffold(
                appBar: AppBar(title: Text('FlutterShare')),
                body: SingleChildScrollView(
                  child: SinglePost(post, user),
                ),
              );
            },
          ),
        );
      },
      child: cachedImage(post.mediaUrl),
    );
  }

  Widget changeOrientation(ValueNotifier<bool> grid) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon: const Icon(Icons.grid_on),
          onPressed: () => grid.value = true,
          color: grid.value ? Colors.pink : null,
        ),
        IconButton(
          icon: const Icon(Icons.list),
          onPressed: () => grid.value = false,
          color: !grid.value ? Colors.pink : null,
        ),
      ],
    );
  }

  Widget _buildGrid(BuildContext context) {
    final gridTiles = <GridTile>[];
    for (final post in posts) {
      gridTiles.add(GridTile(child: postTile(context, post)));
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
          backgroundImage: CachedNetworkImageProvider(user.photoUrl),
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
                      Text(posts.length.toString()),
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
    );
  }

  Widget _buildInfo() {
    return Column(
      children: [
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
              // user.bio,
              'Bio!'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final grid = useState(true);
    return BlocProvider(
      create: (context) => getIt<UserActionsBloc>()
        ..add(UserActionsEvent.fetchProfile('5QNxqcDLc5hrjox6Hf0VAbADLqy2')),
      child: BlocBuilder<UserActionsBloc, UserActionsState>(
        builder: (context, state) {
          return state.maybeMap(
            orElse: () => CircularProgressIndicator(),
            error: (_) => Text(''),
            loaded: (state) {
              final profile = state.profile;

              user = profile.user;
              posts = profile.posts;
              following = profile.following;
              followers = profile.followers;

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
                  changeOrientation(grid),
                  const Divider(height: 0),
                  // _buildGrid(context),
                  if (grid.value)
                    _buildGrid(context)
                  else
                    Column(
                      children: posts.map((e) => SinglePost(e, user)).toList(),
                    )
                  // if (grid) _buildGrid(context) else PostsPage(),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
