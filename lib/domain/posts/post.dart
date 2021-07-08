import 'package:freezed_annotation/freezed_annotation.dart';

part 'post.freezed.dart';
part 'post.g.dart';

@freezed
class Post with _$Post {
  const factory Post({
  @JsonKey(ignore: true) String? id,
    required String ownerid,
    required String mediaUrl,
    required String caption,
    required String location,
    required Map<String, dynamic> likes,
  }) = _Post;

  factory Post.empty() => Post(
        id: 'fgdfgdfdgf',
        ownerid: '',
        mediaUrl: '',
        caption: '',
        location: '',
        likes: {},
      );

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json).copyWith(id: 'sdfsdfs');
  // Map<String, dynamic> toJson() => _$PostToJson(this);
}