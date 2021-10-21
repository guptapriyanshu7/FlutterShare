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

class ProfilePage extends StatelessWidget {
  const ProfilePage(@PathParam('profileId') this.id, {Key? key})
      : super(key: key);
  final String id;

  @override
  Widget build(BuildContext context) {
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
                error: (_) => const Text(''),
                loaded: (_) => _BuildProfile(profile: _.profile),
                orElse: () => const Center(child: CircularProgressIndicator()),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _BuildProfile extends StatelessWidget {
  const _BuildProfile({
    Key? key,
    required this.profile,
  }) : super(key: key);

  final Profile profile;

  @override
  Widget build(BuildContext context) {
    final user = profile.user;
    final posts = profile.posts;
    return ListView(
      children: [
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              _BuildHeader(profile: profile),
              _BuildInfo(user: user),
            ],
          ),
        ),
        _ChangeOrientation(
          user: user,
          posts: posts,
        ),
      ],
    );
  }
}

class _ChangeOrientation extends HookWidget {
  const _ChangeOrientation({
    Key? key,
    required this.user,
    required this.posts,
  }) : super(key: key);

  final User user;
  final List<Post> posts;

  @override
  Widget build(BuildContext context) {
    final grid = useState(true);
    return Column(
      children: [
        const Divider(height: 0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.grid_on),
              onPressed: () => grid.value = true,
              color: grid.value ? Colors.white : Colors.grey,
            ),
            IconButton(
              icon: const Icon(Icons.list),
              onPressed: () => grid.value = false,
              color: !grid.value ? Colors.white : Colors.grey,
            ),
          ],
        ),
        const Divider(height: 0),
        if (grid.value)
          _BuildGrid(posts: posts, user: user)
        else
          ...posts.map((post) => SinglePost(post, user)),
      ],
    );
  }
}

class _BuildGrid extends StatelessWidget {
  const _BuildGrid({
    Key? key,
    required this.posts,
    required this.user,
  }) : super(key: key);

  final List<Post> posts;
  final User user;

  @override
  Widget build(BuildContext context) {
    final List<GridTile> gridTiles = [];
    for (final post in posts) {
      gridTiles.add(
        GridTile(
          child: _PostTile(
            post: post,
            user: user,
          ),
        ),
      );
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
}

class _PostTile extends StatelessWidget {
  const _PostTile({
    Key? key,
    required this.post,
    required this.user,
  }) : super(key: key);

  final Post post;
  final User user;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pushRoute(
        SinglePostRoute(
          userId: user.id,
          postId: post.id,
        ),
      ),
      child: CachedImage(mediaUrl: post.mediaUrl),
    );
  }
}

class _BuildInfo extends StatelessWidget {
  const _BuildInfo({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
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
                // fontWeight: FontWeight.bold,
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
}

class _BuildHeader extends StatelessWidget {
  const _BuildHeader({
    Key? key,
    required this.profile,
  }) : super(key: key);

  final Profile profile;

  @override
  Widget build(BuildContext context) {
    final user = profile.user;
    final posts = profile.posts;
    final following = profile.following;
    final followers = profile.followers;

    return Row(
      children: [
        CircleAvatar(
          radius: 45,
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
                    Column(
                      children: [
                        Text(
                          posts.length.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        const Text('Posts')
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          followers.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        const Text('Followers')
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          following.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        const Text('Following')
                      ],
                    ),
                  ],
                ),
              ),
              _BuildButtons(profile: profile),
            ],
          ),
        ),
      ],
    );
  }
}

class _BuildButtons extends StatelessWidget {
  const _BuildButtons({
    Key? key,
    required this.profile,
  }) : super(key: key);

  final Profile profile;

  @override
  Widget build(BuildContext context) {
    final isFollowing = profile.isFollowing;
    final currentUserId = profile.currentUserId;
    return SizedBox(
      height: 25,
      width: 200,
      child: currentUserId == profile.user.id
          ? OutlinedButton(
              onPressed: () {},
              child: const Text(
                'Edit Profile',
                style: TextStyle(color: Colors.white),
              ),
            )
          : OutlinedButton(
              style: isFollowing
                  ? null
                  : OutlinedButton.styleFrom(backgroundColor: Colors.blue),
              onPressed: () {
                context
                    .read<UserActionsBloc>()
                    .add(UserActionsEvent.followProfile(profile));
              },
              child: isFollowing
                  ? const Text(
                      'Unfollow',
                      style: TextStyle(color: Colors.white),
                    )
                  : const Text(
                      'Follow',
                      style: TextStyle(color: Colors.white),
                    ),
            ),
    );
  }
}

class CachedImage extends StatelessWidget {
  const CachedImage({
    Key? key,
    required this.mediaUrl,
  }) : super(key: key);

  final String mediaUrl;

  @override
  Widget build(BuildContext context) {
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
}
