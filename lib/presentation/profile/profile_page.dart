import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:flutter_share/application/user_actions/user_actions_bloc.dart';
import 'package:flutter_share/domain/auth/user.dart';
import 'package:flutter_share/domain/posts/post.dart';
import 'package:flutter_share/domain/user_actions/profile.dart';
import 'package:flutter_share/injection.dart';
import 'package:flutter_share/presentation/profile/widgets/single_post.dart';
import 'package:flutter_share/presentation/routes/router.gr.dart';

Widget cachedImage(String mediaUrl) {
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
  const ProfilePage(@PathParam('profileId') this.id, {Key? key}) : super(key: key);
  final String id;

  Widget postTile(BuildContext context, Post post, User user) {
    return GestureDetector(
      onTap: () => context.pushRoute(SinglePostRoute(
        userId: user.id,
        postId: post.id,
      )),
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

  Widget _buildGrid(BuildContext context, List<Post> posts, User user) {
    final gridTiles = <GridTile>[];
    for (final post in posts) {
      gridTiles.add(GridTile(child: postTile(context, post, user)));
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

  Widget buildButtons(
    BuildContext context,
    Profile profile,
  ) {
    final isFollowing = profile.isFollowing;
    final currentUserId = profile.currentUserId;
    return SizedBox(
      height: 25,
      width: 200,
      child: currentUserId == id
          ? OutlinedButton(
              // onPressed: editProfile,
              onPressed: () {},
              child: const Text('Edit Profile'),
            )
          : OutlinedButton(
              onPressed: () {
                context
                    .read<UserActionsBloc>()
                    .add(UserActionsEvent.followProfile(profile));
              },
              child:
                  isFollowing ? const Text('Unfollow') : const Text('Follow'),
            ),
    );
  }

  Widget _buildHeader(BuildContext context, Profile profile) {
    final user = profile.user;
    final posts = profile.posts;
    final following = profile.following;
    final followers = profile.followers;

    return Row(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: CachedNetworkImageProvider(user.photoUrl),
        ),
        Expanded(
          // flex: 1,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
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
              buildButtons(
                context,
                profile,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfo(User user) {
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
          child: Text(user.bio),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final grid = useState(true);
    return BlocProvider(
      create: (context) =>
          getIt<UserActionsBloc>()..add(UserActionsEvent.fetchProfile(id)),
      child: BlocBuilder<UserActionsBloc, UserActionsState>(
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () async => context
                .read<UserActionsBloc>()
                .add(UserActionsEvent.fetchProfile(id)),
            child: Scaffold(
              body: state.maybeMap(
                orElse: () => const Center(child: CircularProgressIndicator()),
                error: (_) => const Text(''),
                loaded: (state) {
                  final profile = state.profile;
                  final user = profile.user;
                  final posts = profile.posts;
                  return ListView(
                    children: [
                      const SizedBox(height: 4),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            _buildHeader(context, profile),
                            _buildInfo(user),
                          ],
                        ),
                      ),
                      const Divider(height: 0),
                      changeOrientation(grid),
                      const Divider(height: 0),
                      // _buildGrid(context),
                      if (grid.value)
                        _buildGrid(context, posts, user)
                      else
                        Column(
                          children:
                              posts.map((e) => SinglePost(e, user)).toList(),
                        )
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
