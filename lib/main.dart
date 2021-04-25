import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/pages/home.dart';
import 'package:flutter_share/widgets/progress.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterShare',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        accentColor: Colors.pink[200],
      ),
      home: FutureBuilder(
        future: initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
            return Text('Something went wrong!');
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Home();
          }
          return circularIndicator();
        },
      ),
    );
  }
}
