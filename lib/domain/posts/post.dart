import 'package:flutter_share/domain/auth/i_auth_facade.dart';
import 'package:flutter_share/domain/core/errors.dart';
import 'package:flutter_share/injection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'post.freezed.dart';
part 'post.g.dart';

@freezed
class Post with _$Post {
  const factory Post({
    required String id,
    required String ownerid,
    required String mediaUrl,
    required String caption,
    required String location,
    required Map<String, bool> likes,
  }) = _Post;
  factory Post.empty() {
    final currentUserId = getIt<IAuthFacade>()
        .getSignedInUser()
        .getOrElse(() => throw NotAuthenticatedError())
        .id;
    return Post(
      id: const Uuid().v4(),
      ownerid: currentUserId,
      mediaUrl: '',
      caption: '',
      location: '',
      likes: {},
    );
  }

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}
