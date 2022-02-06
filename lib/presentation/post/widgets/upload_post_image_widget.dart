import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter_share/application/post/save_post/save_post_bloc.dart';

class UploadPostImageWidget extends HookWidget {
  const UploadPostImageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final file = useState(File('some path'));
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.35,
      child: BlocListener<SavePostBloc, SavePostState>(
        listenWhen: (previous, current) => previous.isSaving == true,
        listener: (context, state) {
          if (state.failureOption.isNone()) file.value = File('some path');
        },
        child: GestureDetector(
          child: file.value.path != 'some path'
              ? Image.file(file.value)
              : const Icon(
                  Icons.camera_alt_rounded,
                  color: Colors.white,
                  size: 60,
                ),
          onTap: () async {
            final pickedFile = await ImagePicker().pickImage(
              source: ImageSource.gallery,
              imageQuality: 70,
            );
            if (pickedFile != null) {
              file.value = File(pickedFile.path);
              context
                  .read<SavePostBloc>()
                  .add(SavePostEvent.filePicked(file.value));
            }
          },
        ),
      ),
    );
  }
}
