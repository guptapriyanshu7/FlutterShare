import 'package:flutter/material.dart';

PreferredSizeWidget header(BuildContext context, String title) {
  return AppBar(
    automaticallyImplyLeading: false,
    title: Text(title),
    centerTitle: true,
    // backgroundColor: Theme.of(context).accentColor,
  );
}
