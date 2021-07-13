import 'package:auto_route/auto_route.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_share/application/auth/auth_bloc.dart';
import 'package:flutter_share/main.dart';
import 'package:flutter_share/presentation/routes/router.gr.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> _setUpInitial() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    RemoteNotification? notification = initialMessage?.notification;
    if (notification != null) {
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(notification.body ?? ''),
          );
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _setUpInitial();
    FirebaseMessaging.onMessage.listen(
      (message) {
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;

        if (notification != null && android != null) {
          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                icon: '@mipmap/ic_launcher',
              ),
            ),
          );
        }
      },
    );
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;

        if (notification != null && android != null) {
          showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.body ?? ''),
              );
            },
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return state.maybeMap(
          orElse: () => CircularProgressIndicator(),
          authenticated: (_) => AutoTabsScaffold(
            key: _scaffoldKey,
            routes: [
              SavePostRoute(),
              ActivityFeedRoute(),
              SearchRoute(),
              ProfileRoute(id: _.currentUser.id),
            ],
            bottomNavigationBuilder: (_, tabsRouter) {
              return BottomNavigationBar(
                currentIndex: tabsRouter.activeIndex,
                onTap: tabsRouter.setActiveIndex,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.add_a_photo_outlined),
                    label: 'New Post',
                    backgroundColor: Colors.red,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.notifications),
                    label: 'Notifications',
                    backgroundColor: Colors.red,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.search),
                    label: 'Search',
                    backgroundColor: Colors.red,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.account_box),
                    label: 'Account',
                    backgroundColor: Colors.red,
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
