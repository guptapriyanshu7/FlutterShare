import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_share/application/auth/auth_bloc.dart';
import 'package:flutter_share/presentation/routes/router.gr.dart';
import 'package:auto_route/auto_route.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.map(
          initial: (_) {},
          unauthenticated: (_) => context.replaceRoute(SignInRoute()),
          authenticated: (_) => context.replaceRoute(HomeRoute()),
        );
      },
      child: Scaffold(
        body: Center(
          child: FlutterLogo(),
        ),
      ),
    );
  }
}
