import 'package:auto_route/annotations.dart';
import 'package:flutter_share/presentation/auth/sign_in_page.dart';
import 'package:flutter_share/presentation/home_page.dart';
import 'package:flutter_share/presentation/post/posts_page.dart';
import 'package:flutter_share/presentation/post/save_post_page.dart';
import 'package:flutter_share/presentation/profile/profile_page.dart';
import 'package:flutter_share/presentation/routes/router.gr.dart';
import 'package:flutter_share/presentation/splash/splash_page.dart';
import 'package:injectable/injectable.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    AutoRoute(page: SplashPage, initial: true),
    AutoRoute(page: SignInPage),
    AutoRoute(
      page: HomePage,
      children: [
        AutoRoute(page: SavePostPage),
        AutoRoute(page: PostsPage),
        AutoRoute(page: ProfilePage),
      ],
    ),
  ],
)
class $Router {}

@module
abstract class RouterInjectableModule {
  @lazySingleton
  Router get router => Router();
}
