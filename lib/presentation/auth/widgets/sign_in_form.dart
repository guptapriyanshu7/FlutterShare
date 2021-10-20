import 'package:another_flushbar/flushbar_helper.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_share/application/auth/auth_bloc.dart';
import 'package:flutter_share/application/auth/sign_in_form/sign_in_form_bloc.dart';
import 'package:flutter_share/presentation/routes/router.gr.dart';

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
              context
                  .read<AuthBloc>()
                  .add(const AuthEvent.authCheckRequested());
              context.replaceRoute(const HomeRoute());
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
              padding: const EdgeInsets.all(16),
              children: [
                const SizedBox(height: 150),
                const Center(
                  child: Text(
                    'FlutterShare',
                    style: TextStyle(
                      fontFamily: 'Billabong',
                      fontSize: 60,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    hintText: 'Email',
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                  // decoration: const InputDecoration(
                  //   // prefixIcon: Icon(Icons.email),
                  //   labelText: 'Email',
                  // ),
                  onChanged: (value) =>
                      signInFormBloc.add(SignInFormEvent.emailChanged(value)),
                  // validator: (_) =>
                  //     signInFormBloc.state.emailAddress.value.fold(
                  //   (l) => l.maybeMap(
                  //     invalidEmail: (_) => 'Invalid Email',
                  //     orElse: () => null,
                  //   ),
                  //   (r) => null,
                  // ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  autocorrect: false,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                    filled: true,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (value) => signInFormBloc.add(
                    SignInFormEvent.passwordChanged(value),
                  ),
                  // validator: (_) => signInFormBloc.state.password.value.fold(
                  //   (l) => l.maybeMap(
                  //     shortPassword: (_) => 'Short Password',
                  //     orElse: () => null,
                  //   ),
                  //   (r) => null,
                  // ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          currentFocus.unfocus();
                          signInFormBloc.add(
                            const SignInFormEvent
                                .signInWithEmailAndPasswordPressed(),
                          );
                        },
                        child: const Text('SIGN IN'),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          currentFocus.unfocus();
                          signInFormBloc.add(
                            const SignInFormEvent
                                .registerWithEmailAndPasswordPressed(),
                          );
                        },
                        child: const Text('REGISTER'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Expanded(
                      child: Divider(
                        color: Colors.white,
                        // height: 20,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      child: const Text('OR'),
                    ),
                    const Expanded(
                      child: Divider(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () => signInFormBloc.add(
                    const SignInFormEvent.signInWithGooglePressed(),
                  ),
                  child: state.isSubmitting
                      ? SizedBox(
                          height: 14,
                          width: 14,
                          child: Transform.scale(
                            scale: 1.5,
                            child: const CircularProgressIndicator(
                              strokeWidth: 1.2,
                              color: Colors.white,
                            ),
                          ),
                        )
                      : const Text(
                          'Log in with Google',
                          style: TextStyle(
                              // fontWeight: FontWeight.bold,
                              ),
                        ),
                ),
                // if (state.isSubmitting) ...[
                //   const SizedBox(height: 12),
                //   const LinearProgressIndicator(),
                // ]
              ],
            ),
          ),
        );
      },
    );
  }
}
