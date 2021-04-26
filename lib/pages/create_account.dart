import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_share/widgets/header.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  String username;
  final formkey = GlobalKey<FormState>();

  void submit() {
    final form = formkey.currentState;
    if (form.validate()) {
      form.save();
      final snackbar = SnackBar(
        content: Text('Welcome $username'),
        duration: Duration(milliseconds: 1500),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      Timer(Duration(seconds: 2), () {
        Navigator.pop(context, username);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, 'Create Username'),
      body: Column(
        children: [
          SizedBox(height: 40),
          Form(
            autovalidateMode: AutovalidateMode.always,
            key: formkey,
            child: TextFormField(
              validator: (val) {
                if (val.trim().length < 3)
                  return 'Username too short!';
                else if (val.trim().length > 12)
                  return 'Username too big!';
                else
                  return null;
              },
              onSaved: (val) => username = val.trim(),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: submit,
            child: Text('Submit'),
          )
        ],
      ),
    );
  }
}
