import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/domain/auth/user.dart';
import 'package:flutter_share/domain/posts/post.dart';
import 'package:flutter_share/presentation/profile/widgets/single_post.dart';

class SinglePostPage extends StatelessWidget {
  final Post post;
  final User user;
  const SinglePostPage(@PathParam('postId') id, this.post, this.user,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('FlutterShare')),
      body: SingleChildScrollView(
        child: SinglePost(post, user),
      ),
    );
  }
}
