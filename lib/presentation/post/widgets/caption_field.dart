import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_share/application/auth/auth_bloc.dart';
import 'package:flutter_share/application/post/save_post/save_post_bloc.dart';
import 'package:flutter_share/domain/core/validators.dart';

class CaptionField extends StatelessWidget {
  const CaptionField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final photoUrl = context.read<AuthBloc>().state.maybeMap(
          orElse: () {},
          authenticated: (_) => _.currentUser.photoUrl,
        );
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: CachedNetworkImageProvider(photoUrl!),
      ),
      title: TextFormField(
        onChanged: (value) => context
            .read<SavePostBloc>()
            .add(SavePostEvent.captionChanged(value)),
        maxLength: CAPTION_MAX_LENGTH,
        maxLines: null,
        minLines: 3,
        validator: (_) {
          if (_ == null || !validateStringNotEmpty(_)) {
            return 'Caption is empty.';
          } else if (!validateMaxStringLength(_, CAPTION_MAX_LENGTH)) {
            return 'Max length .';
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
