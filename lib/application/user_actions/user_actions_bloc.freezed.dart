// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'user_actions_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$UserActionsEventTearOff {
  const _$UserActionsEventTearOff();

  _FetchProfile fetchProfile(String userId) {
    return _FetchProfile(
      userId,
    );
  }

  _CheckLikeStatus checkLikeStatus(Post post) {
    return _CheckLikeStatus(
      post,
    );
  }

  _LikePost likePost(bool likeStatus, Post post) {
    return _LikePost(
      likeStatus,
      post,
    );
  }

  _FollowUser followProfile(Profile profile) {
    return _FollowUser(
      profile,
    );
  }
}

/// @nodoc
const $UserActionsEvent = _$UserActionsEventTearOff();

/// @nodoc
mixin _$UserActionsEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userId) fetchProfile,
    required TResult Function(Post post) checkLikeStatus,
    required TResult Function(bool likeStatus, Post post) likePost,
    required TResult Function(Profile profile) followProfile,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId)? fetchProfile,
    TResult Function(Post post)? checkLikeStatus,
    TResult Function(bool likeStatus, Post post)? likePost,
    TResult Function(Profile profile)? followProfile,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FetchProfile value) fetchProfile,
    required TResult Function(_CheckLikeStatus value) checkLikeStatus,
    required TResult Function(_LikePost value) likePost,
    required TResult Function(_FollowUser value) followProfile,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FetchProfile value)? fetchProfile,
    TResult Function(_CheckLikeStatus value)? checkLikeStatus,
    TResult Function(_LikePost value)? likePost,
    TResult Function(_FollowUser value)? followProfile,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserActionsEventCopyWith<$Res> {
  factory $UserActionsEventCopyWith(
          UserActionsEvent value, $Res Function(UserActionsEvent) then) =
      _$UserActionsEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$UserActionsEventCopyWithImpl<$Res>
    implements $UserActionsEventCopyWith<$Res> {
  _$UserActionsEventCopyWithImpl(this._value, this._then);

  final UserActionsEvent _value;
  // ignore: unused_field
  final $Res Function(UserActionsEvent) _then;
}

/// @nodoc
abstract class _$FetchProfileCopyWith<$Res> {
  factory _$FetchProfileCopyWith(
          _FetchProfile value, $Res Function(_FetchProfile) then) =
      __$FetchProfileCopyWithImpl<$Res>;
  $Res call({String userId});
}

/// @nodoc
class __$FetchProfileCopyWithImpl<$Res>
    extends _$UserActionsEventCopyWithImpl<$Res>
    implements _$FetchProfileCopyWith<$Res> {
  __$FetchProfileCopyWithImpl(
      _FetchProfile _value, $Res Function(_FetchProfile) _then)
      : super(_value, (v) => _then(v as _FetchProfile));

  @override
  _FetchProfile get _value => super._value as _FetchProfile;

  @override
  $Res call({
    Object? userId = freezed,
  }) {
    return _then(_FetchProfile(
      userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_FetchProfile implements _FetchProfile {
  const _$_FetchProfile(this.userId);

  @override
  final String userId;

  @override
  String toString() {
    return 'UserActionsEvent.fetchProfile(userId: $userId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _FetchProfile &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(userId);

  @JsonKey(ignore: true)
  @override
  _$FetchProfileCopyWith<_FetchProfile> get copyWith =>
      __$FetchProfileCopyWithImpl<_FetchProfile>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userId) fetchProfile,
    required TResult Function(Post post) checkLikeStatus,
    required TResult Function(bool likeStatus, Post post) likePost,
    required TResult Function(Profile profile) followProfile,
  }) {
    return fetchProfile(userId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId)? fetchProfile,
    TResult Function(Post post)? checkLikeStatus,
    TResult Function(bool likeStatus, Post post)? likePost,
    TResult Function(Profile profile)? followProfile,
    required TResult orElse(),
  }) {
    if (fetchProfile != null) {
      return fetchProfile(userId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FetchProfile value) fetchProfile,
    required TResult Function(_CheckLikeStatus value) checkLikeStatus,
    required TResult Function(_LikePost value) likePost,
    required TResult Function(_FollowUser value) followProfile,
  }) {
    return fetchProfile(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FetchProfile value)? fetchProfile,
    TResult Function(_CheckLikeStatus value)? checkLikeStatus,
    TResult Function(_LikePost value)? likePost,
    TResult Function(_FollowUser value)? followProfile,
    required TResult orElse(),
  }) {
    if (fetchProfile != null) {
      return fetchProfile(this);
    }
    return orElse();
  }
}

abstract class _FetchProfile implements UserActionsEvent {
  const factory _FetchProfile(String userId) = _$_FetchProfile;

  String get userId => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$FetchProfileCopyWith<_FetchProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$CheckLikeStatusCopyWith<$Res> {
  factory _$CheckLikeStatusCopyWith(
          _CheckLikeStatus value, $Res Function(_CheckLikeStatus) then) =
      __$CheckLikeStatusCopyWithImpl<$Res>;
  $Res call({Post post});

  $PostCopyWith<$Res> get post;
}

/// @nodoc
class __$CheckLikeStatusCopyWithImpl<$Res>
    extends _$UserActionsEventCopyWithImpl<$Res>
    implements _$CheckLikeStatusCopyWith<$Res> {
  __$CheckLikeStatusCopyWithImpl(
      _CheckLikeStatus _value, $Res Function(_CheckLikeStatus) _then)
      : super(_value, (v) => _then(v as _CheckLikeStatus));

  @override
  _CheckLikeStatus get _value => super._value as _CheckLikeStatus;

  @override
  $Res call({
    Object? post = freezed,
  }) {
    return _then(_CheckLikeStatus(
      post == freezed
          ? _value.post
          : post // ignore: cast_nullable_to_non_nullable
              as Post,
    ));
  }

  @override
  $PostCopyWith<$Res> get post {
    return $PostCopyWith<$Res>(_value.post, (value) {
      return _then(_value.copyWith(post: value));
    });
  }
}

/// @nodoc

class _$_CheckLikeStatus implements _CheckLikeStatus {
  const _$_CheckLikeStatus(this.post);

  @override
  final Post post;

  @override
  String toString() {
    return 'UserActionsEvent.checkLikeStatus(post: $post)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _CheckLikeStatus &&
            (identical(other.post, post) ||
                const DeepCollectionEquality().equals(other.post, post)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(post);

  @JsonKey(ignore: true)
  @override
  _$CheckLikeStatusCopyWith<_CheckLikeStatus> get copyWith =>
      __$CheckLikeStatusCopyWithImpl<_CheckLikeStatus>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userId) fetchProfile,
    required TResult Function(Post post) checkLikeStatus,
    required TResult Function(bool likeStatus, Post post) likePost,
    required TResult Function(Profile profile) followProfile,
  }) {
    return checkLikeStatus(post);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId)? fetchProfile,
    TResult Function(Post post)? checkLikeStatus,
    TResult Function(bool likeStatus, Post post)? likePost,
    TResult Function(Profile profile)? followProfile,
    required TResult orElse(),
  }) {
    if (checkLikeStatus != null) {
      return checkLikeStatus(post);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FetchProfile value) fetchProfile,
    required TResult Function(_CheckLikeStatus value) checkLikeStatus,
    required TResult Function(_LikePost value) likePost,
    required TResult Function(_FollowUser value) followProfile,
  }) {
    return checkLikeStatus(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FetchProfile value)? fetchProfile,
    TResult Function(_CheckLikeStatus value)? checkLikeStatus,
    TResult Function(_LikePost value)? likePost,
    TResult Function(_FollowUser value)? followProfile,
    required TResult orElse(),
  }) {
    if (checkLikeStatus != null) {
      return checkLikeStatus(this);
    }
    return orElse();
  }
}

abstract class _CheckLikeStatus implements UserActionsEvent {
  const factory _CheckLikeStatus(Post post) = _$_CheckLikeStatus;

  Post get post => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$CheckLikeStatusCopyWith<_CheckLikeStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$LikePostCopyWith<$Res> {
  factory _$LikePostCopyWith(_LikePost value, $Res Function(_LikePost) then) =
      __$LikePostCopyWithImpl<$Res>;
  $Res call({bool likeStatus, Post post});

  $PostCopyWith<$Res> get post;
}

/// @nodoc
class __$LikePostCopyWithImpl<$Res> extends _$UserActionsEventCopyWithImpl<$Res>
    implements _$LikePostCopyWith<$Res> {
  __$LikePostCopyWithImpl(_LikePost _value, $Res Function(_LikePost) _then)
      : super(_value, (v) => _then(v as _LikePost));

  @override
  _LikePost get _value => super._value as _LikePost;

  @override
  $Res call({
    Object? likeStatus = freezed,
    Object? post = freezed,
  }) {
    return _then(_LikePost(
      likeStatus == freezed
          ? _value.likeStatus
          : likeStatus // ignore: cast_nullable_to_non_nullable
              as bool,
      post == freezed
          ? _value.post
          : post // ignore: cast_nullable_to_non_nullable
              as Post,
    ));
  }

  @override
  $PostCopyWith<$Res> get post {
    return $PostCopyWith<$Res>(_value.post, (value) {
      return _then(_value.copyWith(post: value));
    });
  }
}

/// @nodoc

class _$_LikePost implements _LikePost {
  const _$_LikePost(this.likeStatus, this.post);

  @override
  final bool likeStatus;
  @override
  final Post post;

  @override
  String toString() {
    return 'UserActionsEvent.likePost(likeStatus: $likeStatus, post: $post)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _LikePost &&
            (identical(other.likeStatus, likeStatus) ||
                const DeepCollectionEquality()
                    .equals(other.likeStatus, likeStatus)) &&
            (identical(other.post, post) ||
                const DeepCollectionEquality().equals(other.post, post)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(likeStatus) ^
      const DeepCollectionEquality().hash(post);

  @JsonKey(ignore: true)
  @override
  _$LikePostCopyWith<_LikePost> get copyWith =>
      __$LikePostCopyWithImpl<_LikePost>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userId) fetchProfile,
    required TResult Function(Post post) checkLikeStatus,
    required TResult Function(bool likeStatus, Post post) likePost,
    required TResult Function(Profile profile) followProfile,
  }) {
    return likePost(likeStatus, post);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId)? fetchProfile,
    TResult Function(Post post)? checkLikeStatus,
    TResult Function(bool likeStatus, Post post)? likePost,
    TResult Function(Profile profile)? followProfile,
    required TResult orElse(),
  }) {
    if (likePost != null) {
      return likePost(likeStatus, post);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FetchProfile value) fetchProfile,
    required TResult Function(_CheckLikeStatus value) checkLikeStatus,
    required TResult Function(_LikePost value) likePost,
    required TResult Function(_FollowUser value) followProfile,
  }) {
    return likePost(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FetchProfile value)? fetchProfile,
    TResult Function(_CheckLikeStatus value)? checkLikeStatus,
    TResult Function(_LikePost value)? likePost,
    TResult Function(_FollowUser value)? followProfile,
    required TResult orElse(),
  }) {
    if (likePost != null) {
      return likePost(this);
    }
    return orElse();
  }
}

abstract class _LikePost implements UserActionsEvent {
  const factory _LikePost(bool likeStatus, Post post) = _$_LikePost;

  bool get likeStatus => throw _privateConstructorUsedError;
  Post get post => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$LikePostCopyWith<_LikePost> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$FollowUserCopyWith<$Res> {
  factory _$FollowUserCopyWith(
          _FollowUser value, $Res Function(_FollowUser) then) =
      __$FollowUserCopyWithImpl<$Res>;
  $Res call({Profile profile});

  $ProfileCopyWith<$Res> get profile;
}

/// @nodoc
class __$FollowUserCopyWithImpl<$Res>
    extends _$UserActionsEventCopyWithImpl<$Res>
    implements _$FollowUserCopyWith<$Res> {
  __$FollowUserCopyWithImpl(
      _FollowUser _value, $Res Function(_FollowUser) _then)
      : super(_value, (v) => _then(v as _FollowUser));

  @override
  _FollowUser get _value => super._value as _FollowUser;

  @override
  $Res call({
    Object? profile = freezed,
  }) {
    return _then(_FollowUser(
      profile == freezed
          ? _value.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as Profile,
    ));
  }

  @override
  $ProfileCopyWith<$Res> get profile {
    return $ProfileCopyWith<$Res>(_value.profile, (value) {
      return _then(_value.copyWith(profile: value));
    });
  }
}

/// @nodoc

class _$_FollowUser implements _FollowUser {
  const _$_FollowUser(this.profile);

  @override
  final Profile profile;

  @override
  String toString() {
    return 'UserActionsEvent.followProfile(profile: $profile)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _FollowUser &&
            (identical(other.profile, profile) ||
                const DeepCollectionEquality().equals(other.profile, profile)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(profile);

  @JsonKey(ignore: true)
  @override
  _$FollowUserCopyWith<_FollowUser> get copyWith =>
      __$FollowUserCopyWithImpl<_FollowUser>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userId) fetchProfile,
    required TResult Function(Post post) checkLikeStatus,
    required TResult Function(bool likeStatus, Post post) likePost,
    required TResult Function(Profile profile) followProfile,
  }) {
    return followProfile(profile);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId)? fetchProfile,
    TResult Function(Post post)? checkLikeStatus,
    TResult Function(bool likeStatus, Post post)? likePost,
    TResult Function(Profile profile)? followProfile,
    required TResult orElse(),
  }) {
    if (followProfile != null) {
      return followProfile(profile);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FetchProfile value) fetchProfile,
    required TResult Function(_CheckLikeStatus value) checkLikeStatus,
    required TResult Function(_LikePost value) likePost,
    required TResult Function(_FollowUser value) followProfile,
  }) {
    return followProfile(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FetchProfile value)? fetchProfile,
    TResult Function(_CheckLikeStatus value)? checkLikeStatus,
    TResult Function(_LikePost value)? likePost,
    TResult Function(_FollowUser value)? followProfile,
    required TResult orElse(),
  }) {
    if (followProfile != null) {
      return followProfile(this);
    }
    return orElse();
  }
}

abstract class _FollowUser implements UserActionsEvent {
  const factory _FollowUser(Profile profile) = _$_FollowUser;

  Profile get profile => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$FollowUserCopyWith<_FollowUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
class _$UserActionsStateTearOff {
  const _$UserActionsStateTearOff();

  _Initial initial() {
    return const _Initial();
  }

  _Loading loading() {
    return const _Loading();
  }

  _LikeStatus likeStatus(bool isLiked) {
    return _LikeStatus(
      isLiked,
    );
  }

  _Error error(UserActionsFailure failure) {
    return _Error(
      failure,
    );
  }

  _Loaded loaded(Profile profile) {
    return _Loaded(
      profile,
    );
  }
}

/// @nodoc
const $UserActionsState = _$UserActionsStateTearOff();

/// @nodoc
mixin _$UserActionsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(bool isLiked) likeStatus,
    required TResult Function(UserActionsFailure failure) error,
    required TResult Function(Profile profile) loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(bool isLiked)? likeStatus,
    TResult Function(UserActionsFailure failure)? error,
    TResult Function(Profile profile)? loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_LikeStatus value) likeStatus,
    required TResult Function(_Error value) error,
    required TResult Function(_Loaded value) loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_LikeStatus value)? likeStatus,
    TResult Function(_Error value)? error,
    TResult Function(_Loaded value)? loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserActionsStateCopyWith<$Res> {
  factory $UserActionsStateCopyWith(
          UserActionsState value, $Res Function(UserActionsState) then) =
      _$UserActionsStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$UserActionsStateCopyWithImpl<$Res>
    implements $UserActionsStateCopyWith<$Res> {
  _$UserActionsStateCopyWithImpl(this._value, this._then);

  final UserActionsState _value;
  // ignore: unused_field
  final $Res Function(UserActionsState) _then;
}

/// @nodoc
abstract class _$InitialCopyWith<$Res> {
  factory _$InitialCopyWith(_Initial value, $Res Function(_Initial) then) =
      __$InitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$InitialCopyWithImpl<$Res> extends _$UserActionsStateCopyWithImpl<$Res>
    implements _$InitialCopyWith<$Res> {
  __$InitialCopyWithImpl(_Initial _value, $Res Function(_Initial) _then)
      : super(_value, (v) => _then(v as _Initial));

  @override
  _Initial get _value => super._value as _Initial;
}

/// @nodoc

class _$_Initial implements _Initial {
  const _$_Initial();

  @override
  String toString() {
    return 'UserActionsState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _Initial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(bool isLiked) likeStatus,
    required TResult Function(UserActionsFailure failure) error,
    required TResult Function(Profile profile) loaded,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(bool isLiked)? likeStatus,
    TResult Function(UserActionsFailure failure)? error,
    TResult Function(Profile profile)? loaded,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_LikeStatus value) likeStatus,
    required TResult Function(_Error value) error,
    required TResult Function(_Loaded value) loaded,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_LikeStatus value)? likeStatus,
    TResult Function(_Error value)? error,
    TResult Function(_Loaded value)? loaded,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements UserActionsState {
  const factory _Initial() = _$_Initial;
}

/// @nodoc
abstract class _$LoadingCopyWith<$Res> {
  factory _$LoadingCopyWith(_Loading value, $Res Function(_Loading) then) =
      __$LoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$LoadingCopyWithImpl<$Res> extends _$UserActionsStateCopyWithImpl<$Res>
    implements _$LoadingCopyWith<$Res> {
  __$LoadingCopyWithImpl(_Loading _value, $Res Function(_Loading) _then)
      : super(_value, (v) => _then(v as _Loading));

  @override
  _Loading get _value => super._value as _Loading;
}

/// @nodoc

class _$_Loading implements _Loading {
  const _$_Loading();

  @override
  String toString() {
    return 'UserActionsState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _Loading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(bool isLiked) likeStatus,
    required TResult Function(UserActionsFailure failure) error,
    required TResult Function(Profile profile) loaded,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(bool isLiked)? likeStatus,
    TResult Function(UserActionsFailure failure)? error,
    TResult Function(Profile profile)? loaded,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_LikeStatus value) likeStatus,
    required TResult Function(_Error value) error,
    required TResult Function(_Loaded value) loaded,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_LikeStatus value)? likeStatus,
    TResult Function(_Error value)? error,
    TResult Function(_Loaded value)? loaded,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements UserActionsState {
  const factory _Loading() = _$_Loading;
}

/// @nodoc
abstract class _$LikeStatusCopyWith<$Res> {
  factory _$LikeStatusCopyWith(
          _LikeStatus value, $Res Function(_LikeStatus) then) =
      __$LikeStatusCopyWithImpl<$Res>;
  $Res call({bool isLiked});
}

/// @nodoc
class __$LikeStatusCopyWithImpl<$Res>
    extends _$UserActionsStateCopyWithImpl<$Res>
    implements _$LikeStatusCopyWith<$Res> {
  __$LikeStatusCopyWithImpl(
      _LikeStatus _value, $Res Function(_LikeStatus) _then)
      : super(_value, (v) => _then(v as _LikeStatus));

  @override
  _LikeStatus get _value => super._value as _LikeStatus;

  @override
  $Res call({
    Object? isLiked = freezed,
  }) {
    return _then(_LikeStatus(
      isLiked == freezed
          ? _value.isLiked
          : isLiked // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_LikeStatus implements _LikeStatus {
  const _$_LikeStatus(this.isLiked);

  @override
  final bool isLiked;

  @override
  String toString() {
    return 'UserActionsState.likeStatus(isLiked: $isLiked)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _LikeStatus &&
            (identical(other.isLiked, isLiked) ||
                const DeepCollectionEquality().equals(other.isLiked, isLiked)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(isLiked);

  @JsonKey(ignore: true)
  @override
  _$LikeStatusCopyWith<_LikeStatus> get copyWith =>
      __$LikeStatusCopyWithImpl<_LikeStatus>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(bool isLiked) likeStatus,
    required TResult Function(UserActionsFailure failure) error,
    required TResult Function(Profile profile) loaded,
  }) {
    return likeStatus(isLiked);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(bool isLiked)? likeStatus,
    TResult Function(UserActionsFailure failure)? error,
    TResult Function(Profile profile)? loaded,
    required TResult orElse(),
  }) {
    if (likeStatus != null) {
      return likeStatus(isLiked);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_LikeStatus value) likeStatus,
    required TResult Function(_Error value) error,
    required TResult Function(_Loaded value) loaded,
  }) {
    return likeStatus(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_LikeStatus value)? likeStatus,
    TResult Function(_Error value)? error,
    TResult Function(_Loaded value)? loaded,
    required TResult orElse(),
  }) {
    if (likeStatus != null) {
      return likeStatus(this);
    }
    return orElse();
  }
}

abstract class _LikeStatus implements UserActionsState {
  const factory _LikeStatus(bool isLiked) = _$_LikeStatus;

  bool get isLiked => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$LikeStatusCopyWith<_LikeStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$ErrorCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) then) =
      __$ErrorCopyWithImpl<$Res>;
  $Res call({UserActionsFailure failure});

  $UserActionsFailureCopyWith<$Res> get failure;
}

/// @nodoc
class __$ErrorCopyWithImpl<$Res> extends _$UserActionsStateCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(_Error _value, $Res Function(_Error) _then)
      : super(_value, (v) => _then(v as _Error));

  @override
  _Error get _value => super._value as _Error;

  @override
  $Res call({
    Object? failure = freezed,
  }) {
    return _then(_Error(
      failure == freezed
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as UserActionsFailure,
    ));
  }

  @override
  $UserActionsFailureCopyWith<$Res> get failure {
    return $UserActionsFailureCopyWith<$Res>(_value.failure, (value) {
      return _then(_value.copyWith(failure: value));
    });
  }
}

/// @nodoc

class _$_Error implements _Error {
  const _$_Error(this.failure);

  @override
  final UserActionsFailure failure;

  @override
  String toString() {
    return 'UserActionsState.error(failure: $failure)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Error &&
            (identical(other.failure, failure) ||
                const DeepCollectionEquality().equals(other.failure, failure)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(failure);

  @JsonKey(ignore: true)
  @override
  _$ErrorCopyWith<_Error> get copyWith =>
      __$ErrorCopyWithImpl<_Error>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(bool isLiked) likeStatus,
    required TResult Function(UserActionsFailure failure) error,
    required TResult Function(Profile profile) loaded,
  }) {
    return error(failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(bool isLiked)? likeStatus,
    TResult Function(UserActionsFailure failure)? error,
    TResult Function(Profile profile)? loaded,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(failure);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_LikeStatus value) likeStatus,
    required TResult Function(_Error value) error,
    required TResult Function(_Loaded value) loaded,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_LikeStatus value)? likeStatus,
    TResult Function(_Error value)? error,
    TResult Function(_Loaded value)? loaded,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements UserActionsState {
  const factory _Error(UserActionsFailure failure) = _$_Error;

  UserActionsFailure get failure => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$ErrorCopyWith<_Error> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$LoadedCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) then) =
      __$LoadedCopyWithImpl<$Res>;
  $Res call({Profile profile});

  $ProfileCopyWith<$Res> get profile;
}

/// @nodoc
class __$LoadedCopyWithImpl<$Res> extends _$UserActionsStateCopyWithImpl<$Res>
    implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(_Loaded _value, $Res Function(_Loaded) _then)
      : super(_value, (v) => _then(v as _Loaded));

  @override
  _Loaded get _value => super._value as _Loaded;

  @override
  $Res call({
    Object? profile = freezed,
  }) {
    return _then(_Loaded(
      profile == freezed
          ? _value.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as Profile,
    ));
  }

  @override
  $ProfileCopyWith<$Res> get profile {
    return $ProfileCopyWith<$Res>(_value.profile, (value) {
      return _then(_value.copyWith(profile: value));
    });
  }
}

/// @nodoc

class _$_Loaded implements _Loaded {
  const _$_Loaded(this.profile);

  @override
  final Profile profile;

  @override
  String toString() {
    return 'UserActionsState.loaded(profile: $profile)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Loaded &&
            (identical(other.profile, profile) ||
                const DeepCollectionEquality().equals(other.profile, profile)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(profile);

  @JsonKey(ignore: true)
  @override
  _$LoadedCopyWith<_Loaded> get copyWith =>
      __$LoadedCopyWithImpl<_Loaded>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(bool isLiked) likeStatus,
    required TResult Function(UserActionsFailure failure) error,
    required TResult Function(Profile profile) loaded,
  }) {
    return loaded(profile);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(bool isLiked)? likeStatus,
    TResult Function(UserActionsFailure failure)? error,
    TResult Function(Profile profile)? loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(profile);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_LikeStatus value) likeStatus,
    required TResult Function(_Error value) error,
    required TResult Function(_Loaded value) loaded,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_LikeStatus value)? likeStatus,
    TResult Function(_Error value)? error,
    TResult Function(_Loaded value)? loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _Loaded implements UserActionsState {
  const factory _Loaded(Profile profile) = _$_Loaded;

  Profile get profile => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$LoadedCopyWith<_Loaded> get copyWith => throw _privateConstructorUsedError;
}
