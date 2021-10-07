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
      height: MediaQuery.of(context).size.height * 0.2,
      child: GestureDetector(
        child: file.value.path != 'some path'
            ? Image.file(file.value)
            : const Icon(
                Icons.camera_alt_rounded,
                color: Colors.grey,
                size: 60,
              ),
        onTap: () async {
          final pickedFile = await ImagePicker().getImage(
            source: ImageSource.gallery,
            imageQuality: 70,
          );
          // setState(() {
          if (pickedFile != null) {
            file.value = File(pickedFile.path);
            context
            .read<SavePostBloc>()
            .add(SavePostEvent.filePicked(file.value));
          }
          // });
        },
      ),
    );
  }
}
// SizedBox(
//   height: 220,
//   // width: MediaQuery.of(context).size.width * 0.8,
//   child: AspectRatio(
//     aspectRatio: 16 / 9,
//     child: Image.file(file!),
//   ),
// ),
