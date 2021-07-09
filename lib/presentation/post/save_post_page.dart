import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_share/application/auth/auth_bloc.dart';
import 'package:flutter_share/application/post/save_post/save_post_bloc.dart';
import 'package:flutter_share/injection.dart';
import 'package:flutter_share/presentation/post/widgets/caption_field.dart';
import 'package:flutter_share/presentation/post/widgets/get_location_widget.dart';
import 'package:flutter_share/presentation/post/widgets/upload_post_image_widget.dart';
import 'package:flutter_share/presentation/routes/router.gr.dart';

class SavePostPage extends HookWidget {
  const SavePostPage({Key? key}) : super(key: key);

  void _handleSubmit(BuildContext context, GlobalKey<FormState> _formKey) {
    _formKey.currentState!.validate()
        ? context.read<SavePostBloc>().add(const SavePostEvent.save())
        : context.read<SavePostBloc>().add(const SavePostEvent.autoValidate());
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = useMemoized(() => GlobalKey<FormState>());

    return BlocProvider(
      create: (context) => getIt<SavePostBloc>(),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          state.maybeMap(
            unauthenticated: (_) => context.replaceRoute(SignInRoute()),
            orElse: () {},
          );
        },
        child: BlocBuilder<SavePostBloc, SavePostState>(
          builder: (context, state) {
            return Scaffold(
              floatingActionButton: IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  context.read<AuthBloc>().add(const AuthEvent.signedOut());
                },
              ),
              appBar: AppBar(
                title: Text('Save Post'),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.check),
                    onPressed: () => _handleSubmit(context, _formKey),
                  )
                ],
              ),
              body: Form(
                key: _formKey,
                autovalidateMode: state.showErrorMessages
                    ? AutovalidateMode.always
                    : AutovalidateMode.disabled,
                child: ListView(
                  children: [
                    const UploadPostImageWidget(),
                    const CaptionField(),
                    const Divider(),
                    const GetLocationWidget(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
