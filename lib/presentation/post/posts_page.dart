import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_share/application/auth/auth_bloc.dart';
import 'package:flutter_share/application/post/post_bloc.dart';
import 'package:flutter_share/injection.dart';
import 'package:flutter_share/presentation/profile/widgets/single_post.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<PostBloc>()..add(const PostEvent.read()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Share'),
          actions: [
            IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () => context.read<AuthBloc>().add(const AuthEvent.signedOut()),
            ),
          ],
        ),
        body: BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {
            return state.maybeMap(
              readFailure: (state) {
                return const Text('');
              },
              readSuccess: (state) => ListView.builder(
                itemCount: state.posts.length,
                itemBuilder: (_, index) {
                  final tu = state.posts[index];
                  return SinglePost(tu.value1, tu.value2);
                },
              ),
              orElse: () => const Center(child: CircularProgressIndicator()),
            );
          },
        ),
      ),
    );
  }
}
