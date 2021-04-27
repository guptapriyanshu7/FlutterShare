import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/pages/home.dart';

class EditProfile extends StatefulWidget {
  final void Function() logout;
  const EditProfile({this.logout, Key key}) : super(key: key);
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final formkey = GlobalKey<FormState>();

  void update() async {
    final form = formkey.currentState;
    if (form.validate()) {
      form.save();
      await usersRef.doc(currentUser.id).update({
        'bio': currentUser.bio,
        'displayName': currentUser.displayName,
      });
      final snackbar = SnackBar(
        content: Text('Profile Updated!'),
        duration: Duration(milliseconds: 500),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      Timer(Duration(seconds: 1), () {
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text('Edit Profile'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.done),
              color: Colors.green,
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(currentUser.photoUrl),
            radius: 60.0,
          ),
          Form(
              autovalidateMode: AutovalidateMode.always,
              key: formkey,
              child: Column(
                children: [
                  TextFormField(
                    // controller: name,
                    validator: (val) {
                      if (val.trim().length < 3)
                        return 'Name too short!';
                      else if (val.trim().length > 12) return 'Name too big!';
                      return null;
                    },
                    initialValue: currentUser.displayName,
                    onSaved: (val) => currentUser.displayName = val,
                  ),
                  TextFormField(
                    // controller: bio,
                    validator: (val) {
                      if (val.trim().length > 12) return 'Bio too big!';
                      return null;
                    },
                    initialValue: currentUser.bio,
                    onSaved: (val) => currentUser.bio = val,
                  ),
                ],
              )),
          TextButton(
            onPressed: update,
            child: Text('Update'),
          ),
          Container(
            width: 200,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                widget.logout();
              },
              child: Text('Logout'),
            ),
          ),
        ],
      ),
    );
  }
}
