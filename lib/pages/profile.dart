import 'package:flutter/material.dart';
import 'package:flutter_share/widgets/header.dart';

class Profile extends StatelessWidget {
  final void Function() logout;
  const Profile(this.logout, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, 'Profile'),
      body: ElevatedButton(
        onPressed: logout,
        child: Text('Logout'),
      ),
    );
  }
}
