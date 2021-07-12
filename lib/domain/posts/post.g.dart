// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Post _$_$_PostFromJson(Map<String, dynamic> json) {
  return _$_Post(
    id: json['id'] as String,
    ownerid: json['ownerid'] as String,
    mediaUrl: json['mediaUrl'] as String,
    caption: json['caption'] as String,
    location: json['location'] as String,
    likes: Map<String, bool>.from(json['likes'] as Map),
  );
}

Map<String, dynamic> _$_$_PostToJson(_$_Post instance) => <String, dynamic>{
      'id': instance.id,
      'ownerid': instance.ownerid,
      'mediaUrl': instance.mediaUrl,
      'caption': instance.caption,
      'location': instance.location,
      'likes': instance.likes,
    };
