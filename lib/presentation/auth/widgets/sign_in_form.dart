import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_share/application/auth/auth_bloc.dart';
import 'package:flutter_share/application/auth/sign_in_form/sign_in_form_bloc.dart';
import 'package:flutter_share/presentation/routes/router.gr.dart';
import 'package:auto_route/auto_route.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInFormBloc, SignInFormState>(
      listener: (context, state) {
        state.authFailureOrSuccessOption.fold(
          () => null,
          (e) => e.fold(
            (l) {
              FlushbarHelper.createError(
                message: l.map(
                  cancelledByUser: (_) => 'Cancelled',
                  serverError: (_) => 'Server error',
                  emailAlreadyInUse: (_) => 'Email already in use',
                  invalidEmailAndPasswordCombination: (_) =>
                      'Invalid email and password combination',
                ),
              ).show(context);
            },
            (_) {
              context.replaceRoute(NotesOverviewRoute());
              context
                  .read<AuthBloc>()
                  .add(const AuthEvent.authCheckRequested());
            },
          ),
        );
      },
      builder: (context, state) {
        final signInFormBloc = context.read<SignInFormBloc>();
        // or BlocProvider.of<SignInFormBloc>(context);
        final currentFocus = FocusScope.of(context);
        return Form(
          autovalidateMode: state.showErrorMessages
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          child: GestureDetector(
            onTap: () {
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: ListView(
              padding: EdgeInsets.all(12),
              children: [
                SizedBox(height: 12),
                Text(
                  '📝',
                  style: TextStyle(fontSize: 130),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 12),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    labelText: 'Email',
                  ),
                  onChanged: (value) =>
                      signInFormBloc.add(SignInFormEvent.emailChanged(value)),
                  validator: (_) =>
                      signInFormBloc.state.emailAddress.value.fold(
                    (l) => l.maybeMap(
                      invalidEmail: (_) => 'Invalid Email',
                      orElse: () => null,
                    ),
                    (r) => null,
                  ),
                ),
                SizedBox(height: 12),
                TextFormField(
                  autocorrect: false,
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    labelText: 'Password',
                  ),
                  onChanged: (value) => signInFormBloc.add(
                    SignInFormEvent.passwordChanged(value),
                  ),
                  validator: (_) => signInFormBloc.state.password.value.fold(
                    (l) => l.maybeMap(
                      shortPassword: (_) => 'Short Password',
                      orElse: () => null,
                    ),
                    (r) => null,
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          currentFocus.unfocus();
                          signInFormBloc.add(
                            SignInFormEvent.signInWithEmailAndPasswordPressed(),
                          );
                        },
                        child: Text('SIGN IN'),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          currentFocus.unfocus();
                          signInFormBloc.add(
                            SignInFormEvent
                                .registerWithEmailAndPasswordPressed(),
                          );
                        },
                        child: Text('REGISTER'),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () => signInFormBloc.add(
                    SignInFormEvent.signInWithGooglePressed(),
                  ),
                  child: Text(
                    'Sign in with Google',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (state.isSubmitting) ...[
                  SizedBox(height: 12),
                  LinearProgressIndicator(),
                ]
              ],
            ),
          ),
        );
      },
    );
  }
}
