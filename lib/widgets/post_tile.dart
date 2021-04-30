import 'package:flutter/material.dart';
import 'package:flutter_share/widgets/cachedImage.dart';
import 'package:flutter_share/widgets/header.dart';
import 'package:flutter_share/pages/post.dart';
import 'package:flutter_share/models/post.dart' as model;

Widget postTile(context, model.Post post) {
  return GestureDetector(
    child: cachedImage(post.mediaUrl),
    onTap: () async {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return Scaffold(
              appBar: header(context, 'FlutterShare'),
              body: SingleChildScrollView(
                child: Post(post),
              ),
            );
          },
        ),
      );
    },
  );
}
