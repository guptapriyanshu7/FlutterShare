import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:flutter_share/application/post/save_post/save_post_bloc.dart';
import 'package:flutter_share/injection.dart';
import 'package:flutter_share/presentation/post/widgets/caption_field.dart';
import 'package:flutter_share/presentation/post/widgets/get_location_widget.dart';
import 'package:flutter_share/presentation/post/widgets/upload_post_image_widget.dart';

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
      child: BlocConsumer<SavePostBloc, SavePostState>(
        listenWhen: (previous, current) =>
            previous.isSaving != current.isSaving,
        listener: (context, state) {
          if (state.isSaving) {
            showDialog(
              context: context,
              builder: (_) {
                return const Center(child: CircularProgressIndicator());
              },
            );
          } else {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Save Post'),
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.check),
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
                children: const [
                  UploadPostImageWidget(),
                  CaptionField(),
                  Divider(),
                  GetLocationWidget(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
