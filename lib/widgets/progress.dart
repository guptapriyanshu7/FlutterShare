import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget circularIndicator() {
  return Container(
    alignment: Alignment.center,
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(Colors.pink),
    ),
  );
}

Widget linearIndicator() {
  return Container(
    padding: EdgeInsets.only(bottom: 10),
    child: LinearProgressIndicator(
      valueColor: AlwaysStoppedAnimation(Colors.pink),
    ),
  );
}
