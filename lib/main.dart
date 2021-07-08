import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/injection.dart';
import 'package:flutter_share/pages/home.dart';
import 'package:flutter_share/presentation/post/posts_page.dart';
import 'package:flutter_share/presentation/post/save_post_page.dart';
import 'package:flutter_share/widgets/progress.dart';
import 'package:injectable/injectable.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;
  configureInjection(Environment.prod);
  runApp(MyApp(camera: firstCamera));
}

class MyApp extends StatelessWidget {
  final CameraDescription camera;
  final initialization = Firebase.initializeApp();
  MyApp({Key? key, required this.camera}) : super(key: key);
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
            return const Text('Something went wrong!');
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return SavePostPage();
          }
          return circularIndicator();
        },
      ),
    );
  }
}
