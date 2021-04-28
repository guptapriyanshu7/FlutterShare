import 'package:flutter/material.dart';
import 'package:flutter_share/models/post.dart';
import 'package:flutter_share/widgets/cachedImage.dart';

class PostTile extends StatelessWidget {
  final Post post;
  const PostTile(this.post, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: cachedImage(post.mediaUrl),
      onTap: () => print('open post'),
    );
  }
}
