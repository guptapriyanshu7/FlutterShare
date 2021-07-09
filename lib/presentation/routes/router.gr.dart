// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;

import '../auth/sign_in_page.dart' as _i4;
import '../home_page.dart' as _i5;
import '../post/posts_page.dart' as _i7;
import '../post/save_post_page.dart' as _i6;
import '../profile/profile_page.dart' as _i8;
import '../splash/splash_page.dart' as _i3;

class Router extends _i1.RootStackRouter {
  Router([_i2.GlobalKey<_i2.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    SplashRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i3.SplashPage();
        }),
    SignInRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i4.SignInPage();
        }),
    HomeRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i5.HomePage();
        }),
    SavePostRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i6.SavePostPage();
        }),
    PostsRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i7.PostsPage();
        }),
    ProfileRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<ProfileRouteArgs>(
              orElse: () => const ProfileRouteArgs());
          return _i8.ProfilePage(key: args.key);
        })
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(SplashRoute.name, path: '/'),
        _i1.RouteConfig(SignInRoute.name, path: '/sign-in-page'),
        _i1.RouteConfig(HomeRoute.name, path: '/home-page', children: [
          _i1.RouteConfig(SavePostRoute.name, path: 'save-post-page'),
          _i1.RouteConfig(PostsRoute.name, path: 'posts-page'),
          _i1.RouteConfig(ProfileRoute.name, path: 'profile-page')
        ])
      ];
}

class SplashRoute extends _i1.PageRouteInfo {
  const SplashRoute() : super(name, path: '/');

  static const String name = 'SplashRoute';
}

class SignInRoute extends _i1.PageRouteInfo {
  const SignInRoute() : super(name, path: '/sign-in-page');

  static const String name = 'SignInRoute';
}

class HomeRoute extends _i1.PageRouteInfo {
  const HomeRoute({List<_i1.PageRouteInfo>? children})
      : super(name, path: '/home-page', initialChildren: children);

  static const String name = 'HomeRoute';
}

class SavePostRoute extends _i1.PageRouteInfo {
  const SavePostRoute() : super(name, path: 'save-post-page');

  static const String name = 'SavePostRoute';
}

class PostsRoute extends _i1.PageRouteInfo {
  const PostsRoute() : super(name, path: 'posts-page');

  static const String name = 'PostsRoute';
}

class ProfileRoute extends _i1.PageRouteInfo<ProfileRouteArgs> {
  ProfileRoute({_i2.Key? key})
      : super(name, path: 'profile-page', args: ProfileRouteArgs(key: key));

  static const String name = 'ProfileRoute';
}

class ProfileRouteArgs {
  const ProfileRouteArgs({this.key});

  final _i2.Key? key;
}
