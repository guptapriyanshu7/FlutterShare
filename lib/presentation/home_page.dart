import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
          authenticated: (_) => _TabsScaffold(
            currentUserId: _.currentUser.id,
            photoUrl: _.currentUser.photoUrl,
          ),
        );
      },
    );
  }
}

class _TabsScaffold extends StatelessWidget {
  const _TabsScaffold({
    Key? key,
    required this.currentUserId,
    required this.photoUrl,
  }) : super(key: key);

  final String currentUserId;
  final String photoUrl;

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
          type: BottomNavigationBarType.fixed,
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          selectedIconTheme: const IconThemeData(color: Colors.white),
          unselectedIconTheme: const IconThemeData(color: Colors.white),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.search_outlined),
              activeIcon: Icon(Icons.search),
              label: 'Search',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline),
              activeIcon: Icon(Icons.add_circle),
              label: 'New Post',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border_outlined),
              activeIcon: Icon(Icons.favorite),
              label: 'Notifications',
            ),
            BottomNavigationBarItem(
              icon: CircleAvatar(
                radius: 12,
                foregroundImage: CachedNetworkImageProvider(photoUrl),
              ),
              activeIcon: CircleAvatar(
                radius: 12,
                foregroundImage: CachedNetworkImageProvider(photoUrl),
              ),
              label: 'Account',
            ),
          ],
        );
      },
    );
  }
}
