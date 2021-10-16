import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_share/application/post/post_bloc.dart';
import 'package:flutter_share/injection.dart';
import 'package:flutter_share/presentation/profile/widgets/single_post.dart';

class SinglePostPage extends StatelessWidget {
  final String userId;
  final String postId;

  const SinglePostPage(
    @PathParam('userId') this.userId,
    @PathParam('postId') this.postId, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<PostBloc>()..add(PostEvent.getPost(userId, postId)),
      child: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(title: const Text('FlutterShare')),
            body: state.maybeMap(
              orElse: () => const Center(child: CircularProgressIndicator()),
              getPostSuccess: (_) =>
                  SingleChildScrollView(child: SinglePost(_.post, _.user)),
            ),
          );
        },
      ),
    );
  }
}
