// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;

import '../../domain/auth/user.dart' as _i12;
import '../../domain/posts/post.dart' as _i11;
import '../auth/sign_in_page.dart' as _i4;
import '../home_page.dart' as _i7;
import '../post/posts_page.dart' as _i9;
import '../post/save_post_page.dart' as _i8;
import '../profile/profile_page.dart' as _i5;
import '../profile/single_post_page.dart' as _i6;
import '../search/search_page.dart' as _i10;
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
    ProfileRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final pathParams = data.pathParams;
          final args = data.argsAs<ProfileRouteArgs>(
              orElse: () =>
                  ProfileRouteArgs(id: pathParams.getString('profileId')));
          return _i5.ProfilePage(args.id, key: args.key);
        }),
    SinglePostRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<SinglePostRouteArgs>();
          return _i6.SinglePostPage(args.id, args.post, args.user,
              key: args.key);
        }),
    HomeRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i7.HomePage();
        }),
    SavePostRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i8.SavePostPage();
        }),
    PostsRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i9.PostsPage();
        }),
    SearchRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i10.SearchPage();
        })
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(SplashRoute.name, path: '/'),
        _i1.RouteConfig(SignInRoute.name, path: '/sign-in-page'),
        _i1.RouteConfig(ProfileRoute.name, path: 'profile-page/:profileId'),
        _i1.RouteConfig(SinglePostRoute.name, path: 'single-post-page/:postId'),
        _i1.RouteConfig(HomeRoute.name, path: '/home-page', children: [
          _i1.RouteConfig(SavePostRoute.name, path: 'save-post-page'),
          _i1.RouteConfig(PostsRoute.name, path: 'posts-page'),
          _i1.RouteConfig(ProfileRoute.name, path: 'profile-page/:profileId'),
          _i1.RouteConfig(SearchRoute.name, path: 'search-page')
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

class ProfileRoute extends _i1.PageRouteInfo<ProfileRouteArgs> {
  ProfileRoute({required String id, _i2.Key? key})
      : super(name,
            path: 'profile-page/:profileId',
            args: ProfileRouteArgs(id: id, key: key),
            rawPathParams: {'profileId': id});

  static const String name = 'ProfileRoute';
}

class ProfileRouteArgs {
  const ProfileRouteArgs({required this.id, this.key});

  final String id;

  final _i2.Key? key;
}

class SinglePostRoute extends _i1.PageRouteInfo<SinglePostRouteArgs> {
  SinglePostRoute(
      {required dynamic id,
      required _i11.Post post,
      required _i12.User user,
      _i2.Key? key})
      : super(name,
            path: 'single-post-page/:postId',
            args: SinglePostRouteArgs(id: id, post: post, user: user, key: key),
            rawPathParams: {'postId': id});

  static const String name = 'SinglePostRoute';
}

class SinglePostRouteArgs {
  const SinglePostRouteArgs(
      {required this.id, required this.post, required this.user, this.key});

  final dynamic id;

  final _i11.Post post;

  final _i12.User user;

  final _i2.Key? key;
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

class SearchRoute extends _i1.PageRouteInfo {
  const SearchRoute() : super(name, path: 'search-page');

  static const String name = 'SearchRoute';
}
