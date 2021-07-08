import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_share/application/post/post_bloc.dart';
import 'package:flutter_share/injection.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<PostBloc>()..add(PostEvent.read()),
      child: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          print('object');
          return state.maybeMap(
            readFailure: (state) {
              print('readFailure');
              return Text('');
            },
            readSuccess: (state) => Scaffold(
              appBar: AppBar(
                title: Text('Flutter Share'),
              ),
              body: ListView.builder(
                itemCount: state.posts.length,
                itemBuilder: (_, index) {
                  final post = state.posts[index];
                  return Card(
                    child: Column(
                      children: [
                        Image.network(post.mediaUrl),
                        Text(post.caption),
                      ],
                    ),
                  );
                },
              ),
            ),
            orElse: () => CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
