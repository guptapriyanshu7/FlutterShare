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
    formkey.currentState.save();
    Navigator.pop(context, username);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, 'Create Username'),
      body: Column(
        children: [
          SizedBox(height: 40),
          Form(
            key: formkey,
            child: TextFormField(
              onSaved: (val) => username = val,
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
