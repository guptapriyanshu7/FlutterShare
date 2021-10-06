import 'package:auto_route/annotations.dart';
import 'package:flutter_share/presentation/activity_feed/activity_feed_page.dart';
import 'package:flutter_share/presentation/auth/sign_in_page.dart';
import 'package:flutter_share/presentation/comments/comments_page.dart';
import 'package:flutter_share/presentation/home_page.dart';
import 'package:flutter_share/presentation/post/posts_page.dart';
import 'package:flutter_share/presentation/post/save_post_page.dart';
import 'package:flutter_share/presentation/profile/profile_page.dart';
import 'package:flutter_share/presentation/profile/single_post_page.dart';
import 'package:flutter_share/presentation/routes/router.gr.dart';
import 'package:flutter_share/presentation/search/search_page.dart';
import 'package:flutter_share/presentation/splash/splash_page.dart';
import 'package:injectable/injectable.dart';

const PROFILE_ROUTE_PATH = 'profile-page/:profileId';
const SINGLE_POST_ROUTE_PATH = 'single-post-page/:userId/:postId';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    AutoRoute(page: SplashPage, initial: true),
    AutoRoute(page: SignInPage),
    AutoRoute(page: CommentsPage),
    AutoRoute(page: ProfilePage, path: PROFILE_ROUTE_PATH),
    AutoRoute(page: SinglePostPage, path: SINGLE_POST_ROUTE_PATH),
    AutoRoute(
      page: HomePage,
      children: [
        AutoRoute(page: SavePostPage),
        AutoRoute(page: PostsPage),
        AutoRoute(page: ActivityFeedPage),
        AutoRoute(page: ProfilePage, path: PROFILE_ROUTE_PATH),
        AutoRoute(page: SearchPage),
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
