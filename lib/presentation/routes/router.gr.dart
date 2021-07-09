// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;

import '../../domain/notes/note.dart' as _i7;
import '../auth/sign_in_page.dart' as _i4;
import '../notes/note_form/note_form_page.dart' as _i6;
import '../notes/notes_overveiw/notes_overview_page.dart' as _i5;
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
    NotesOverviewRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i5.NotesOverviewPage();
        }),
    NoteFormRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<NoteFormRouteArgs>(
              orElse: () => const NoteFormRouteArgs());
          return _i6.NoteFormPage(editNote: args.editNote, key: args.key);
        },
        fullscreenDialog: true)
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(SplashRoute.name, path: '/'),
        _i1.RouteConfig(SignInRoute.name, path: '/sign-in-page'),
        _i1.RouteConfig(NotesOverviewRoute.name, path: '/notes-overview-page'),
        _i1.RouteConfig(NoteFormRoute.name, path: '/note-form-page')
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

class NotesOverviewRoute extends _i1.PageRouteInfo {
  const NotesOverviewRoute() : super(name, path: '/notes-overview-page');

  static const String name = 'NotesOverviewRoute';
}

class NoteFormRoute extends _i1.PageRouteInfo<NoteFormRouteArgs> {
  NoteFormRoute({_i7.Note? editNote, _i2.Key? key})
      : super(name,
            path: '/note-form-page',
            args: NoteFormRouteArgs(editNote: editNote, key: key));

  static const String name = 'NoteFormRoute';
}

class NoteFormRouteArgs {
  const NoteFormRouteArgs({this.editNote, this.key});

  final _i7.Note? editNote;

  final _i2.Key? key;
}
