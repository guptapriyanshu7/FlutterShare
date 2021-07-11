import 'package:flutter_share/domain/auth/user.dart';
import 'package:flutter_share/domain/posts/post.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile.freezed.dart';

@freezed
class Profile with _$Profile {
  const factory Profile({
    required User user,
    required List<Post> posts,
    required int followers,
    required int following,
    required bool isFollowing,
  }) = _Profile;
}
