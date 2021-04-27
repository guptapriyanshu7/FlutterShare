import 'package:flutter/material.dart';

class Post extends StatelessWidget {
  const Post({Key key}) : super(key: key);
  int getLikesCount(Map<String, bool> likes) {
    // if(likes == null) {
    //   return 0;
    // }
    var count = 0;
    likes.values.forEach((val) {
      if (val == true) count += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(''),
    );
  }
}
