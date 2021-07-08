import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_share/application/post/save_post/save_post_bloc.dart';
import 'package:flutter_share/injection.dart';
import 'package:flutter_share/presentation/post/widgets/caption_field.dart';
import 'package:flutter_share/presentation/post/widgets/get_location_widget.dart';

class SavePostPage extends StatelessWidget {
  SavePostPage({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  void _handleSubmit(BuildContext context) {
    _formKey.currentState!.validate()
        ? context.read<SavePostBloc>().add(const SavePostEvent.save())
        : context.read<SavePostBloc>().add(const SavePostEvent.autoValidate());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SavePostBloc>(),
      child: BlocBuilder<SavePostBloc, SavePostState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Save Post'),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.check),
                  onPressed: () => _handleSubmit(context),
                )
              ],
            ),
            body: Form(
              key: _formKey,
              autovalidateMode:
                  // state.showErrorMessages
                  //     ?
                  AutovalidateMode.always,
              // : AutovalidateMode.disabled,
              child: ListView(
                children: [
                  // SizedBox(
                  //   height: 220,
                  //   // width: MediaQuery.of(context).size.width * 0.8,
                  //   child: AspectRatio(
                  //     aspectRatio: 16 / 9,
                  //     child: Image.file(file!),
                  //   ),
                  // ),
                  CaptionField(),
                  const Divider(),
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
