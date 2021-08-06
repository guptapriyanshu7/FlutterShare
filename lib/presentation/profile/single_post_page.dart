import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_share/application/post/post_bloc.dart';
import 'package:flutter_share/domain/auth/user.dart';
import 'package:flutter_share/domain/posts/post.dart';
import 'package:flutter_share/injection.dart';
import 'package:flutter_share/presentation/profile/widgets/single_post.dart';

class SinglePostPage extends StatelessWidget {
  final Post post;
  final User user;
  const SinglePostPage(@PathParam('postId') id, this.post, this.user,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<PostBloc>()..add(PostEvent.getPost(user.id, post.id)),
      child: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(title: Text('FlutterShare')),
            body: state.maybeMap(
              orElse: () {
                return CircularProgressIndicator();
              },
              getPostSuccess: (_) {
                return SingleChildScrollView(
                  child: SinglePost(_.post, _.user),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
