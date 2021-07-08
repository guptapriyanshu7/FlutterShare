import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget circularIndicator() {
  return Container(
    alignment: Alignment.center,
    child: const CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(Colors.pink),
    ),
  );
}

Widget linearIndicator() {
  return Container(
    padding: const EdgeInsets.only(bottom: 10),
    child: const LinearProgressIndicator(
      valueColor: AlwaysStoppedAnimation(Colors.pink),
    ),
  );
}
