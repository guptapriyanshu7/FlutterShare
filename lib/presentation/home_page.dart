import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/presentation/routes/router.gr.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: [
        SavePostRoute(),
        ProfileRoute(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) {
        return BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.add_a_photo_outlined),
              label: 'New Post',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_box),
              label: 'Account',
            ),
          ],
        );
      },
    );
  }
}
