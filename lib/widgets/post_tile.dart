import 'package:flutter/material.dart';
import 'package:flutter_share/widgets/cached_image.dart';
import 'package:flutter_share/widgets/header.dart';
import 'package:flutter_share/pages/post.dart';
import 'package:flutter_share/domain/posts/post.dart' as model;

Widget postTile(BuildContext context, model.Post post) {
  return GestureDetector(
    onTap: () async {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return Scaffold(
              appBar: header(context, 'FlutterShare'),
              body: SingleChildScrollView(
                // child: Post(post),
              ),
            );
          },
        ),
      );
    },
    child: cachedImage(post.mediaUrl),
  );
}
