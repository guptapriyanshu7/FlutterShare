import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/models/user.dart' as user_model;
import 'package:flutter_share/pages/activity_feed.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_share/pages/camera.dart';
import 'package:flutter_share/pages/create_account.dart';
import 'package:flutter_share/pages/profile.dart';
import 'package:flutter_share/pages/search.dart';
import 'package:flutter_share/pages/timeline.dart';
import 'package:flutter_share/pages/upload.dart';
import 'package:google_sign_in/google_sign_in.dart';

final googleSignIn = GoogleSignIn();
final usersRef = FirebaseFirestore.instance.collection('users');
final postsRef = FirebaseFirestore.instance.collection('posts');
final commentsRef = FirebaseFirestore.instance.collection('comments');
final feedRef = FirebaseFirestore.instance.collection('feed');
final followingRef = FirebaseFirestore.instance.collection('following');
final followersRef = FirebaseFirestore.instance.collection('followers');  
final auth = FirebaseAuth.instance;
final storage = FirebaseStorage.instance;
user_model.User? currentUser;
int pageIndex = 0;

class Home extends StatefulWidget {
  final CameraDescription? camera;
  const Home({Key? key, this.camera}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isAuth = false;
  PageController? pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    auth.userChanges().listen((User? user) {
      if (user == null) {
        setState(() {
          isAuth = false;
        });
      } else {
        handleSignIn(user);
      }
    });
    // googleSignIn.onCurrentUserChanged.listen((account) {
    //   handleSignIn(account);
    // });
    // googleSignIn.signInSilently().then((account) {
    //   handleSignIn(account);
    // });
  }

  Future<UserCredential> signInWithGoogle() async {
    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return auth.signInWithCredential(credential);
  }

  @override
  void dispose() {
    pageController?.dispose();
    super.dispose();
  }

  Future<void> handleSignIn(User account) async {
    print('User signed in!: $account');
    var doc = await usersRef.doc(account.uid).get();
    if (!doc.exists) {
      final String? username = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CreateAccount()),
      );
      usersRef.doc(account.uid).set({
        'username': username,
        'photoUrl': account.photoURL,
        'email': account.email,
        'displayName': account.displayName,
        'bio': '',
        'timestamp': DateTime.now(),
      });
      doc = await usersRef.doc(account.uid).get();
    }
    currentUser = user_model.User.fromDocument(doc);
    print(currentUser?.id);

    setState(() {
      isAuth = true;
    });
  }

  Widget authorizedScreen() {
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        children: [
          const Timeline(),
          ActivityFeed(),
          const Upload(),
          Camera(camera: widget.camera),
          const Search(),
          Profile(currentUser!.id),
        ],
        // physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: pageIndex,
        onTap: onTap,
        activeColor: Theme.of(context).primaryColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.whatshot),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_active),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.photo_camera,
              size: 35,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
          ),
        ],
      ),
    );
  }

  Widget unAuthorizedScreen() {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Theme.of(context).accentColor,
              Theme.of(context).primaryColor,
            ],
          ),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'FlutterShare',
              style: TextStyle(
                color: Colors.white,
                fontSize: 60,
              ),
            ),
            GestureDetector(
              onTap: login,
              child: Container(
                width: 260,
                height: 50,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/google_auth.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void onPageChanged(int pI) {
    setState(() {
      pageIndex = pI;
    });
  }

  void onTap(int pageIndex) {
    pageController?.animateToPage(
      pageIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void login() {
    signInWithGoogle();
  }

  @override
  Widget build(BuildContext context) {
    print(pageIndex);
    return isAuth ? authorizedScreen() : unAuthorizedScreen();
  }
}
