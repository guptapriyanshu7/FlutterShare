import 'package:flutter/material.dart';

Widget header(BuildContext context, String title) {
  return AppBar(
    title: Text(title),
    centerTitle: true,
    // backgroundColor: Theme.of(context).accentColor,
  );
}
