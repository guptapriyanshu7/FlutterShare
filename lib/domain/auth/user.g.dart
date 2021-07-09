// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_User _$_$_UserFromJson(Map<String, dynamic> json) {
  return _$_User(
    id: json['id'] as String,
    username: json['username'] as String,
    email: json['email'] as String,
    photoUrl: json['photoUrl'] as String,
    displayName: json['displayName'] as String,
    bio: json['bio'] as String,
  );
}

Map<String, dynamic> _$_$_UserToJson(_$_User instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'photoUrl': instance.photoUrl,
      'displayName': instance.displayName,
      'bio': instance.bio,
    };
