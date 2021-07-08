import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/pages/home.dart';

class EditProfile extends StatelessWidget {
  late final formkey = GlobalKey<FormState>();

  Future<void> update(BuildContext context) async {
    final form = formkey.currentState;
    if (form!.validate()) {
      form.save();
      await usersRef.doc(currentUser!.id).update({
        'bio': currentUser!.bio,
        'displayName': currentUser!.displayName,
      });
      const snackbar = SnackBar(
        content: Text('Profile Updated!'),
        duration: Duration(milliseconds: 500),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      Timer(const Duration(seconds: 1), () {
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
        title: const Text('Edit Profile'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.done),
              color: Colors.green,
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              CircleAvatar(
                radius: 50.0,
                backgroundImage:
                    CachedNetworkImageProvider(currentUser!.photoUrl),
              ),
              const SizedBox(
                height: 10,
              ),
              Form(
                autovalidateMode: AutovalidateMode.always,
                key: formkey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Display Name"),
                      TextFormField(
                        validator: (val) {
                          if (val!.trim().length < 3) {
                            return 'Name too short!';
                          } else if (val.trim().length > 50) {
                            return 'Name too big!';
                          }
                          return null;
                        },
                        initialValue: currentUser!.displayName,
                        onSaved: (val) => currentUser!.displayName = val!,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text("Bio"),
                      TextFormField(
                        validator: (val) {
                          if (val!.trim().length > 12) return 'Bio too big!';
                          return null;
                        },
                        initialValue: currentUser!.bio,
                        onSaved: (val) => currentUser!.bio = val!,
                      ),
                    ],
                  ),
                ),
              ),
              TextButton(
                onPressed: () => update(context),
                child: const Text('Update'),
              ),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    pageIndex = 0;
                    googleSignIn.signOut();
                    auth.signOut();
                  },
                  child: const Text('Logout'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
