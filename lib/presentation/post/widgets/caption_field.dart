import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_share/application/post/save_post/save_post_bloc.dart';
import 'package:flutter_share/domain/core/validators.dart';

class CaptionField extends StatelessWidget {
  const CaptionField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: CachedNetworkImageProvider(
          'https://firebasestorage.googleapis.com/v0/b/flutter-share-d228b.appspot.com/o/post_173f6a52-fe2e-4ca0-af33-fe81a5abc1ad.jpg?alt=media&token=90df9b6d-288a-4471-9967-4940b7c827ae',
          // currentUser!.photoUrl,
        ),
      ),
      title: TextFormField(
        onChanged: (value) => context.read<SavePostBloc>().add(
              SavePostEvent.captionChanged(value),
            ),
        maxLength: CAPTION_MAX_LENGTH,
        maxLines: null,
        minLines: 3,
        validator: (_) {
          if (_ == null || !validateStringNotEmpty(_)) {
            return 'Caption is empty.';
          } else if (!validateMaxStringLength(_, CAPTION_MAX_LENGTH)) {
            return 'Max length ${CAPTION_MAX_LENGTH}.';
          }
          return null;
        },
        decoration: const InputDecoration(
          hintText: 'Enter a Caption...',
          counterText: '',
          border: InputBorder.none,
        ),
      ),
    );
  }
}
