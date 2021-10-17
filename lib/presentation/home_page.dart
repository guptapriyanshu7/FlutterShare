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
  Future<void> _setUpInitial() async {
    final RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    final RemoteNotification? notification = initialMessage?.notification;
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
        final RemoteNotification? notification = message.notification;
        final AndroidNotification? android = message.notification?.android;

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
        final RemoteNotification? notification = message.notification;
        final AndroidNotification? android = message.notification?.android;

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
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        state.maybeMap(
          orElse: () => context.replaceRoute(const SignInRoute()),
          authenticated: (_) {},
        );
      },
      builder: (context, state) {
        return state.maybeMap(
          orElse: () => const Material(
            child: Center(child: CircularProgressIndicator()),
          ),
          authenticated: (_) => _TabsScaffold(currentUserId: _.currentUser.id),
        );
      },
    );
  }
}

class _TabsScaffold extends StatelessWidget {
  const _TabsScaffold({
    Key? key,
    required this.currentUserId,
  }) : super(key: key);

  final String currentUserId;

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: [
        const PostsRoute(),
        const SearchRoute(),
        const SavePostRoute(),
        const ActivityFeedRoute(),
        ProfileRoute(id: currentUserId),
      ],
      bottomNavigationBuilder: (_, tabsRouter) {
        return BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.red,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
              backgroundColor: Colors.red,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.camera_alt),
              label: 'New Post',
              backgroundColor: Colors.red,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'Notifications',
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
    );
  }
}
