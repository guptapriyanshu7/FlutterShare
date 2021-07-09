// import 'package:camera/camera.dart';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_share/application/auth/auth_bloc.dart';
import 'package:flutter_share/injection.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_share/presentation/routes/router.gr.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // final cameras = await availableCameras();
  // final firstCamera = cameras.first;
  configureInjection(Environment.prod);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // final CameraDescription camera;
  // final _router = Router();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<AuthBloc>()..add(AuthEvent.authCheckRequested()),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return MaterialApp.router(
            routeInformationParser: getIt<Router>().defaultRouteParser(),
            routerDelegate: AutoRouterDelegate.declarative(
              getIt<Router>(),
              routes: (_) => [
                state.map(
                  initial: (_) => SplashRoute(),
                  unauthenticated: (_) => SignInRoute(),
                  authenticated: (_) => HomeRoute(),
                )
              ],
            ),
            title: 'FlutterShare',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.red,
              accentColor: Colors.pink[200],
            ),
          );
        },
      ),
    );
  }
}
