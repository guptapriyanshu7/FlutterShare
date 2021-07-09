import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_share/application/auth/sign_in_form/sign_in_form_bloc.dart';
import 'package:flutter_share/injection.dart';
import 'package:flutter_share/presentation/auth/widgets/sign_in_form.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In/Register'),
      ),
      body: BlocProvider(
        create: (_) => getIt<SignInFormBloc>(),
        child: SignInForm(),
      ),
    );
  }
}
