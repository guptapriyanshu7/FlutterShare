import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_share/application/auth/auth_bloc.dart';
import 'package:flutter_share/presentation/routes/router.gr.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.map(
          initial: (_) {},
          unauthenticated: (_) => context.replaceRoute(const SignInRoute()),
          authenticated: (_) => context.replaceRoute(const HomeRoute()),
        );
      },
      child: const Scaffold(
        body: Center(
          child: FlutterLogo(size: 100),
        ),
      ),
    );
  }
}
