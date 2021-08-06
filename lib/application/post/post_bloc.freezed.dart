// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'post_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$PostEventTearOff {
  const _$PostEventTearOff();

  _Read read() {
    return const _Read();
  }

  _Delete delete(Post post) {
    return _Delete(
      post,
    );
  }

  _GetPost getPost(String userId, String postId) {
    return _GetPost(
      userId,
      postId,
    );
  }
}

/// @nodoc
const $PostEvent = _$PostEventTearOff();

/// @nodoc
mixin _$PostEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() read,
    required TResult Function(Post post) delete,
    required TResult Function(String userId, String postId) getPost,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? read,
    TResult Function(Post post)? delete,
    TResult Function(String userId, String postId)? getPost,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Read value) read,
    required TResult Function(_Delete value) delete,
    required TResult Function(_GetPost value) getPost,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Read value)? read,
    TResult Function(_Delete value)? delete,
    TResult Function(_GetPost value)? getPost,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostEventCopyWith<$Res> {
  factory $PostEventCopyWith(PostEvent value, $Res Function(PostEvent) then) =
      _$PostEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$PostEventCopyWithImpl<$Res> implements $PostEventCopyWith<$Res> {
  _$PostEventCopyWithImpl(this._value, this._then);

  final PostEvent _value;
  // ignore: unused_field
  final $Res Function(PostEvent) _then;
}

/// @nodoc
abstract class _$ReadCopyWith<$Res> {
  factory _$ReadCopyWith(_Read value, $Res Function(_Read) then) =
      __$ReadCopyWithImpl<$Res>;
}

/// @nodoc
class __$ReadCopyWithImpl<$Res> extends _$PostEventCopyWithImpl<$Res>
    implements _$ReadCopyWith<$Res> {
  __$ReadCopyWithImpl(_Read _value, $Res Function(_Read) _then)
      : super(_value, (v) => _then(v as _Read));

  @override
  _Read get _value => super._value as _Read;
}

/// @nodoc

class _$_Read implements _Read {
  const _$_Read();

  @override
  String toString() {
    return 'PostEvent.read()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _Read);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() read,
    required TResult Function(Post post) delete,
    required TResult Function(String userId, String postId) getPost,
  }) {
    return read();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? read,
    TResult Function(Post post)? delete,
    TResult Function(String userId, String postId)? getPost,
    required TResult orElse(),
  }) {
    if (read != null) {
      return read();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Read value) read,
    required TResult Function(_Delete value) delete,
    required TResult Function(_GetPost value) getPost,
  }) {
    return read(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Read value)? read,
    TResult Function(_Delete value)? delete,
    TResult Function(_GetPost value)? getPost,
    required TResult orElse(),
  }) {
    if (read != null) {
      return read(this);
    }
    return orElse();
  }
}

abstract class _Read implements PostEvent {
  const factory _Read() = _$_Read;
}

/// @nodoc
abstract class _$DeleteCopyWith<$Res> {
  factory _$DeleteCopyWith(_Delete value, $Res Function(_Delete) then) =
      __$DeleteCopyWithImpl<$Res>;
  $Res call({Post post});

  $PostCopyWith<$Res> get post;
}

/// @nodoc
class __$DeleteCopyWithImpl<$Res> extends _$PostEventCopyWithImpl<$Res>
    implements _$DeleteCopyWith<$Res> {
  __$DeleteCopyWithImpl(_Delete _value, $Res Function(_Delete) _then)
      : super(_value, (v) => _then(v as _Delete));

  @override
  _Delete get _value => super._value as _Delete;

  @override
  $Res call({
    Object? post = freezed,
  }) {
    return _then(_Delete(
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

class _$_Delete implements _Delete {
  const _$_Delete(this.post);

  @override
  final Post post;

  @override
  String toString() {
    return 'PostEvent.delete(post: $post)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Delete &&
            (identical(other.post, post) ||
                const DeepCollectionEquality().equals(other.post, post)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(post);

  @JsonKey(ignore: true)
  @override
  _$DeleteCopyWith<_Delete> get copyWith =>
      __$DeleteCopyWithImpl<_Delete>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() read,
    required TResult Function(Post post) delete,
    required TResult Function(String userId, String postId) getPost,
  }) {
    return delete(post);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? read,
    TResult Function(Post post)? delete,
    TResult Function(String userId, String postId)? getPost,
    required TResult orElse(),
  }) {
    if (delete != null) {
      return delete(post);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Read value) read,
    required TResult Function(_Delete value) delete,
    required TResult Function(_GetPost value) getPost,
  }) {
    return delete(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Read value)? read,
    TResult Function(_Delete value)? delete,
    TResult Function(_GetPost value)? getPost,
    required TResult orElse(),
  }) {
    if (delete != null) {
      return delete(this);
    }
    return orElse();
  }
}

abstract class _Delete implements PostEvent {
  const factory _Delete(Post post) = _$_Delete;

  Post get post => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$DeleteCopyWith<_Delete> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$GetPostCopyWith<$Res> {
  factory _$GetPostCopyWith(_GetPost value, $Res Function(_GetPost) then) =
      __$GetPostCopyWithImpl<$Res>;
  $Res call({String userId, String postId});
}

/// @nodoc
class __$GetPostCopyWithImpl<$Res> extends _$PostEventCopyWithImpl<$Res>
    implements _$GetPostCopyWith<$Res> {
  __$GetPostCopyWithImpl(_GetPost _value, $Res Function(_GetPost) _then)
      : super(_value, (v) => _then(v as _GetPost));

  @override
  _GetPost get _value => super._value as _GetPost;

  @override
  $Res call({
    Object? userId = freezed,
    Object? postId = freezed,
  }) {
    return _then(_GetPost(
      userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      postId == freezed
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_GetPost implements _GetPost {
  const _$_GetPost(this.userId, this.postId);

  @override
  final String userId;
  @override
  final String postId;

  @override
  String toString() {
    return 'PostEvent.getPost(userId: $userId, postId: $postId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _GetPost &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)) &&
            (identical(other.postId, postId) ||
                const DeepCollectionEquality().equals(other.postId, postId)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(userId) ^
      const DeepCollectionEquality().hash(postId);

  @JsonKey(ignore: true)
  @override
  _$GetPostCopyWith<_GetPost> get copyWith =>
      __$GetPostCopyWithImpl<_GetPost>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() read,
    required TResult Function(Post post) delete,
    required TResult Function(String userId, String postId) getPost,
  }) {
    return getPost(userId, postId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? read,
    TResult Function(Post post)? delete,
    TResult Function(String userId, String postId)? getPost,
    required TResult orElse(),
  }) {
    if (getPost != null) {
      return getPost(userId, postId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Read value) read,
    required TResult Function(_Delete value) delete,
    required TResult Function(_GetPost value) getPost,
  }) {
    return getPost(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Read value)? read,
    TResult Function(_Delete value)? delete,
    TResult Function(_GetPost value)? getPost,
    required TResult orElse(),
  }) {
    if (getPost != null) {
      return getPost(this);
    }
    return orElse();
  }
}

abstract class _GetPost implements PostEvent {
  const factory _GetPost(String userId, String postId) = _$_GetPost;

  String get userId => throw _privateConstructorUsedError;
  String get postId => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$GetPostCopyWith<_GetPost> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
class _$PostStateTearOff {
  const _$PostStateTearOff();

  _Initial initial() {
    return const _Initial();
  }

  _Loading loading() {
    return const _Loading();
  }

  _ReadSuccess readSuccess(List<Post> posts) {
    return _ReadSuccess(
      posts,
    );
  }

  _ReadFailure readFailure(PostFailure failure) {
    return _ReadFailure(
      failure,
    );
  }

  _GetPostSuccess getPostSuccess(Post post, User user) {
    return _GetPostSuccess(
      post,
      user,
    );
  }

  _GetPostFailure getPostFailure(PostFailure failure) {
    return _GetPostFailure(
      failure,
    );
  }

  _DeleteFailure deleteFailure(PostFailure failure) {
    return _DeleteFailure(
      failure,
    );
  }

  _DeleteSuccess deleteSuccess() {
    return const _DeleteSuccess();
  }
}

/// @nodoc
const $PostState = _$PostStateTearOff();

/// @nodoc
mixin _$PostState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Post> posts) readSuccess,
    required TResult Function(PostFailure failure) readFailure,
    required TResult Function(Post post, User user) getPostSuccess,
    required TResult Function(PostFailure failure) getPostFailure,
    required TResult Function(PostFailure failure) deleteFailure,
    required TResult Function() deleteSuccess,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Post> posts)? readSuccess,
    TResult Function(PostFailure failure)? readFailure,
    TResult Function(Post post, User user)? getPostSuccess,
    TResult Function(PostFailure failure)? getPostFailure,
    TResult Function(PostFailure failure)? deleteFailure,
    TResult Function()? deleteSuccess,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_ReadSuccess value) readSuccess,
    required TResult Function(_ReadFailure value) readFailure,
    required TResult Function(_GetPostSuccess value) getPostSuccess,
    required TResult Function(_GetPostFailure value) getPostFailure,
    required TResult Function(_DeleteFailure value) deleteFailure,
    required TResult Function(_DeleteSuccess value) deleteSuccess,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_ReadSuccess value)? readSuccess,
    TResult Function(_ReadFailure value)? readFailure,
    TResult Function(_GetPostSuccess value)? getPostSuccess,
    TResult Function(_GetPostFailure value)? getPostFailure,
    TResult Function(_DeleteFailure value)? deleteFailure,
    TResult Function(_DeleteSuccess value)? deleteSuccess,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostStateCopyWith<$Res> {
  factory $PostStateCopyWith(PostState value, $Res Function(PostState) then) =
      _$PostStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$PostStateCopyWithImpl<$Res> implements $PostStateCopyWith<$Res> {
  _$PostStateCopyWithImpl(this._value, this._then);

  final PostState _value;
  // ignore: unused_field
  final $Res Function(PostState) _then;
}

/// @nodoc
abstract class _$InitialCopyWith<$Res> {
  factory _$InitialCopyWith(_Initial value, $Res Function(_Initial) then) =
      __$InitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$InitialCopyWithImpl<$Res> extends _$PostStateCopyWithImpl<$Res>
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
    return 'PostState.initial()';
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
    required TResult Function(List<Post> posts) readSuccess,
    required TResult Function(PostFailure failure) readFailure,
    required TResult Function(Post post, User user) getPostSuccess,
    required TResult Function(PostFailure failure) getPostFailure,
    required TResult Function(PostFailure failure) deleteFailure,
    required TResult Function() deleteSuccess,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Post> posts)? readSuccess,
    TResult Function(PostFailure failure)? readFailure,
    TResult Function(Post post, User user)? getPostSuccess,
    TResult Function(PostFailure failure)? getPostFailure,
    TResult Function(PostFailure failure)? deleteFailure,
    TResult Function()? deleteSuccess,
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
    required TResult Function(_ReadSuccess value) readSuccess,
    required TResult Function(_ReadFailure value) readFailure,
    required TResult Function(_GetPostSuccess value) getPostSuccess,
    required TResult Function(_GetPostFailure value) getPostFailure,
    required TResult Function(_DeleteFailure value) deleteFailure,
    required TResult Function(_DeleteSuccess value) deleteSuccess,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_ReadSuccess value)? readSuccess,
    TResult Function(_ReadFailure value)? readFailure,
    TResult Function(_GetPostSuccess value)? getPostSuccess,
    TResult Function(_GetPostFailure value)? getPostFailure,
    TResult Function(_DeleteFailure value)? deleteFailure,
    TResult Function(_DeleteSuccess value)? deleteSuccess,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements PostState {
  const factory _Initial() = _$_Initial;
}

/// @nodoc
abstract class _$LoadingCopyWith<$Res> {
  factory _$LoadingCopyWith(_Loading value, $Res Function(_Loading) then) =
      __$LoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$LoadingCopyWithImpl<$Res> extends _$PostStateCopyWithImpl<$Res>
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
    return 'PostState.loading()';
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
    required TResult Function(List<Post> posts) readSuccess,
    required TResult Function(PostFailure failure) readFailure,
    required TResult Function(Post post, User user) getPostSuccess,
    required TResult Function(PostFailure failure) getPostFailure,
    required TResult Function(PostFailure failure) deleteFailure,
    required TResult Function() deleteSuccess,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Post> posts)? readSuccess,
    TResult Function(PostFailure failure)? readFailure,
    TResult Function(Post post, User user)? getPostSuccess,
    TResult Function(PostFailure failure)? getPostFailure,
    TResult Function(PostFailure failure)? deleteFailure,
    TResult Function()? deleteSuccess,
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
    required TResult Function(_ReadSuccess value) readSuccess,
    required TResult Function(_ReadFailure value) readFailure,
    required TResult Function(_GetPostSuccess value) getPostSuccess,
    required TResult Function(_GetPostFailure value) getPostFailure,
    required TResult Function(_DeleteFailure value) deleteFailure,
    required TResult Function(_DeleteSuccess value) deleteSuccess,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_ReadSuccess value)? readSuccess,
    TResult Function(_ReadFailure value)? readFailure,
    TResult Function(_GetPostSuccess value)? getPostSuccess,
    TResult Function(_GetPostFailure value)? getPostFailure,
    TResult Function(_DeleteFailure value)? deleteFailure,
    TResult Function(_DeleteSuccess value)? deleteSuccess,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements PostState {
  const factory _Loading() = _$_Loading;
}

/// @nodoc
abstract class _$ReadSuccessCopyWith<$Res> {
  factory _$ReadSuccessCopyWith(
          _ReadSuccess value, $Res Function(_ReadSuccess) then) =
      __$ReadSuccessCopyWithImpl<$Res>;
  $Res call({List<Post> posts});
}

/// @nodoc
class __$ReadSuccessCopyWithImpl<$Res> extends _$PostStateCopyWithImpl<$Res>
    implements _$ReadSuccessCopyWith<$Res> {
  __$ReadSuccessCopyWithImpl(
      _ReadSuccess _value, $Res Function(_ReadSuccess) _then)
      : super(_value, (v) => _then(v as _ReadSuccess));

  @override
  _ReadSuccess get _value => super._value as _ReadSuccess;

  @override
  $Res call({
    Object? posts = freezed,
  }) {
    return _then(_ReadSuccess(
      posts == freezed
          ? _value.posts
          : posts // ignore: cast_nullable_to_non_nullable
              as List<Post>,
    ));
  }
}

/// @nodoc

class _$_ReadSuccess implements _ReadSuccess {
  const _$_ReadSuccess(this.posts);

  @override
  final List<Post> posts;

  @override
  String toString() {
    return 'PostState.readSuccess(posts: $posts)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ReadSuccess &&
            (identical(other.posts, posts) ||
                const DeepCollectionEquality().equals(other.posts, posts)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(posts);

  @JsonKey(ignore: true)
  @override
  _$ReadSuccessCopyWith<_ReadSuccess> get copyWith =>
      __$ReadSuccessCopyWithImpl<_ReadSuccess>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Post> posts) readSuccess,
    required TResult Function(PostFailure failure) readFailure,
    required TResult Function(Post post, User user) getPostSuccess,
    required TResult Function(PostFailure failure) getPostFailure,
    required TResult Function(PostFailure failure) deleteFailure,
    required TResult Function() deleteSuccess,
  }) {
    return readSuccess(posts);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Post> posts)? readSuccess,
    TResult Function(PostFailure failure)? readFailure,
    TResult Function(Post post, User user)? getPostSuccess,
    TResult Function(PostFailure failure)? getPostFailure,
    TResult Function(PostFailure failure)? deleteFailure,
    TResult Function()? deleteSuccess,
    required TResult orElse(),
  }) {
    if (readSuccess != null) {
      return readSuccess(posts);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_ReadSuccess value) readSuccess,
    required TResult Function(_ReadFailure value) readFailure,
    required TResult Function(_GetPostSuccess value) getPostSuccess,
    required TResult Function(_GetPostFailure value) getPostFailure,
    required TResult Function(_DeleteFailure value) deleteFailure,
    required TResult Function(_DeleteSuccess value) deleteSuccess,
  }) {
    return readSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_ReadSuccess value)? readSuccess,
    TResult Function(_ReadFailure value)? readFailure,
    TResult Function(_GetPostSuccess value)? getPostSuccess,
    TResult Function(_GetPostFailure value)? getPostFailure,
    TResult Function(_DeleteFailure value)? deleteFailure,
    TResult Function(_DeleteSuccess value)? deleteSuccess,
    required TResult orElse(),
  }) {
    if (readSuccess != null) {
      return readSuccess(this);
    }
    return orElse();
  }
}

abstract class _ReadSuccess implements PostState {
  const factory _ReadSuccess(List<Post> posts) = _$_ReadSuccess;

  List<Post> get posts => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$ReadSuccessCopyWith<_ReadSuccess> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$ReadFailureCopyWith<$Res> {
  factory _$ReadFailureCopyWith(
          _ReadFailure value, $Res Function(_ReadFailure) then) =
      __$ReadFailureCopyWithImpl<$Res>;
  $Res call({PostFailure failure});

  $PostFailureCopyWith<$Res> get failure;
}

/// @nodoc
class __$ReadFailureCopyWithImpl<$Res> extends _$PostStateCopyWithImpl<$Res>
    implements _$ReadFailureCopyWith<$Res> {
  __$ReadFailureCopyWithImpl(
      _ReadFailure _value, $Res Function(_ReadFailure) _then)
      : super(_value, (v) => _then(v as _ReadFailure));

  @override
  _ReadFailure get _value => super._value as _ReadFailure;

  @override
  $Res call({
    Object? failure = freezed,
  }) {
    return _then(_ReadFailure(
      failure == freezed
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as PostFailure,
    ));
  }

  @override
  $PostFailureCopyWith<$Res> get failure {
    return $PostFailureCopyWith<$Res>(_value.failure, (value) {
      return _then(_value.copyWith(failure: value));
    });
  }
}

/// @nodoc

class _$_ReadFailure implements _ReadFailure {
  const _$_ReadFailure(this.failure);

  @override
  final PostFailure failure;

  @override
  String toString() {
    return 'PostState.readFailure(failure: $failure)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ReadFailure &&
            (identical(other.failure, failure) ||
                const DeepCollectionEquality().equals(other.failure, failure)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(failure);

  @JsonKey(ignore: true)
  @override
  _$ReadFailureCopyWith<_ReadFailure> get copyWith =>
      __$ReadFailureCopyWithImpl<_ReadFailure>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Post> posts) readSuccess,
    required TResult Function(PostFailure failure) readFailure,
    required TResult Function(Post post, User user) getPostSuccess,
    required TResult Function(PostFailure failure) getPostFailure,
    required TResult Function(PostFailure failure) deleteFailure,
    required TResult Function() deleteSuccess,
  }) {
    return readFailure(failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Post> posts)? readSuccess,
    TResult Function(PostFailure failure)? readFailure,
    TResult Function(Post post, User user)? getPostSuccess,
    TResult Function(PostFailure failure)? getPostFailure,
    TResult Function(PostFailure failure)? deleteFailure,
    TResult Function()? deleteSuccess,
    required TResult orElse(),
  }) {
    if (readFailure != null) {
      return readFailure(failure);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_ReadSuccess value) readSuccess,
    required TResult Function(_ReadFailure value) readFailure,
    required TResult Function(_GetPostSuccess value) getPostSuccess,
    required TResult Function(_GetPostFailure value) getPostFailure,
    required TResult Function(_DeleteFailure value) deleteFailure,
    required TResult Function(_DeleteSuccess value) deleteSuccess,
  }) {
    return readFailure(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_ReadSuccess value)? readSuccess,
    TResult Function(_ReadFailure value)? readFailure,
    TResult Function(_GetPostSuccess value)? getPostSuccess,
    TResult Function(_GetPostFailure value)? getPostFailure,
    TResult Function(_DeleteFailure value)? deleteFailure,
    TResult Function(_DeleteSuccess value)? deleteSuccess,
    required TResult orElse(),
  }) {
    if (readFailure != null) {
      return readFailure(this);
    }
    return orElse();
  }
}

abstract class _ReadFailure implements PostState {
  const factory _ReadFailure(PostFailure failure) = _$_ReadFailure;

  PostFailure get failure => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$ReadFailureCopyWith<_ReadFailure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$GetPostSuccessCopyWith<$Res> {
  factory _$GetPostSuccessCopyWith(
          _GetPostSuccess value, $Res Function(_GetPostSuccess) then) =
      __$GetPostSuccessCopyWithImpl<$Res>;
  $Res call({Post post, User user});

  $PostCopyWith<$Res> get post;
  $UserCopyWith<$Res> get user;
}

/// @nodoc
class __$GetPostSuccessCopyWithImpl<$Res> extends _$PostStateCopyWithImpl<$Res>
    implements _$GetPostSuccessCopyWith<$Res> {
  __$GetPostSuccessCopyWithImpl(
      _GetPostSuccess _value, $Res Function(_GetPostSuccess) _then)
      : super(_value, (v) => _then(v as _GetPostSuccess));

  @override
  _GetPostSuccess get _value => super._value as _GetPostSuccess;

  @override
  $Res call({
    Object? post = freezed,
    Object? user = freezed,
  }) {
    return _then(_GetPostSuccess(
      post == freezed
          ? _value.post
          : post // ignore: cast_nullable_to_non_nullable
              as Post,
      user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
    ));
  }

  @override
  $PostCopyWith<$Res> get post {
    return $PostCopyWith<$Res>(_value.post, (value) {
      return _then(_value.copyWith(post: value));
    });
  }

  @override
  $UserCopyWith<$Res> get user {
    return $UserCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value));
    });
  }
}

/// @nodoc

class _$_GetPostSuccess implements _GetPostSuccess {
  const _$_GetPostSuccess(this.post, this.user);

  @override
  final Post post;
  @override
  final User user;

  @override
  String toString() {
    return 'PostState.getPostSuccess(post: $post, user: $user)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _GetPostSuccess &&
            (identical(other.post, post) ||
                const DeepCollectionEquality().equals(other.post, post)) &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(post) ^
      const DeepCollectionEquality().hash(user);

  @JsonKey(ignore: true)
  @override
  _$GetPostSuccessCopyWith<_GetPostSuccess> get copyWith =>
      __$GetPostSuccessCopyWithImpl<_GetPostSuccess>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Post> posts) readSuccess,
    required TResult Function(PostFailure failure) readFailure,
    required TResult Function(Post post, User user) getPostSuccess,
    required TResult Function(PostFailure failure) getPostFailure,
    required TResult Function(PostFailure failure) deleteFailure,
    required TResult Function() deleteSuccess,
  }) {
    return getPostSuccess(post, user);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Post> posts)? readSuccess,
    TResult Function(PostFailure failure)? readFailure,
    TResult Function(Post post, User user)? getPostSuccess,
    TResult Function(PostFailure failure)? getPostFailure,
    TResult Function(PostFailure failure)? deleteFailure,
    TResult Function()? deleteSuccess,
    required TResult orElse(),
  }) {
    if (getPostSuccess != null) {
      return getPostSuccess(post, user);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_ReadSuccess value) readSuccess,
    required TResult Function(_ReadFailure value) readFailure,
    required TResult Function(_GetPostSuccess value) getPostSuccess,
    required TResult Function(_GetPostFailure value) getPostFailure,
    required TResult Function(_DeleteFailure value) deleteFailure,
    required TResult Function(_DeleteSuccess value) deleteSuccess,
  }) {
    return getPostSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_ReadSuccess value)? readSuccess,
    TResult Function(_ReadFailure value)? readFailure,
    TResult Function(_GetPostSuccess value)? getPostSuccess,
    TResult Function(_GetPostFailure value)? getPostFailure,
    TResult Function(_DeleteFailure value)? deleteFailure,
    TResult Function(_DeleteSuccess value)? deleteSuccess,
    required TResult orElse(),
  }) {
    if (getPostSuccess != null) {
      return getPostSuccess(this);
    }
    return orElse();
  }
}

abstract class _GetPostSuccess implements PostState {
  const factory _GetPostSuccess(Post post, User user) = _$_GetPostSuccess;

  Post get post => throw _privateConstructorUsedError;
  User get user => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$GetPostSuccessCopyWith<_GetPostSuccess> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$GetPostFailureCopyWith<$Res> {
  factory _$GetPostFailureCopyWith(
          _GetPostFailure value, $Res Function(_GetPostFailure) then) =
      __$GetPostFailureCopyWithImpl<$Res>;
  $Res call({PostFailure failure});

  $PostFailureCopyWith<$Res> get failure;
}

/// @nodoc
class __$GetPostFailureCopyWithImpl<$Res> extends _$PostStateCopyWithImpl<$Res>
    implements _$GetPostFailureCopyWith<$Res> {
  __$GetPostFailureCopyWithImpl(
      _GetPostFailure _value, $Res Function(_GetPostFailure) _then)
      : super(_value, (v) => _then(v as _GetPostFailure));

  @override
  _GetPostFailure get _value => super._value as _GetPostFailure;

  @override
  $Res call({
    Object? failure = freezed,
  }) {
    return _then(_GetPostFailure(
      failure == freezed
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as PostFailure,
    ));
  }

  @override
  $PostFailureCopyWith<$Res> get failure {
    return $PostFailureCopyWith<$Res>(_value.failure, (value) {
      return _then(_value.copyWith(failure: value));
    });
  }
}

/// @nodoc

class _$_GetPostFailure implements _GetPostFailure {
  const _$_GetPostFailure(this.failure);

  @override
  final PostFailure failure;

  @override
  String toString() {
    return 'PostState.getPostFailure(failure: $failure)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _GetPostFailure &&
            (identical(other.failure, failure) ||
                const DeepCollectionEquality().equals(other.failure, failure)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(failure);

  @JsonKey(ignore: true)
  @override
  _$GetPostFailureCopyWith<_GetPostFailure> get copyWith =>
      __$GetPostFailureCopyWithImpl<_GetPostFailure>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Post> posts) readSuccess,
    required TResult Function(PostFailure failure) readFailure,
    required TResult Function(Post post, User user) getPostSuccess,
    required TResult Function(PostFailure failure) getPostFailure,
    required TResult Function(PostFailure failure) deleteFailure,
    required TResult Function() deleteSuccess,
  }) {
    return getPostFailure(failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Post> posts)? readSuccess,
    TResult Function(PostFailure failure)? readFailure,
    TResult Function(Post post, User user)? getPostSuccess,
    TResult Function(PostFailure failure)? getPostFailure,
    TResult Function(PostFailure failure)? deleteFailure,
    TResult Function()? deleteSuccess,
    required TResult orElse(),
  }) {
    if (getPostFailure != null) {
      return getPostFailure(failure);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_ReadSuccess value) readSuccess,
    required TResult Function(_ReadFailure value) readFailure,
    required TResult Function(_GetPostSuccess value) getPostSuccess,
    required TResult Function(_GetPostFailure value) getPostFailure,
    required TResult Function(_DeleteFailure value) deleteFailure,
    required TResult Function(_DeleteSuccess value) deleteSuccess,
  }) {
    return getPostFailure(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_ReadSuccess value)? readSuccess,
    TResult Function(_ReadFailure value)? readFailure,
    TResult Function(_GetPostSuccess value)? getPostSuccess,
    TResult Function(_GetPostFailure value)? getPostFailure,
    TResult Function(_DeleteFailure value)? deleteFailure,
    TResult Function(_DeleteSuccess value)? deleteSuccess,
    required TResult orElse(),
  }) {
    if (getPostFailure != null) {
      return getPostFailure(this);
    }
    return orElse();
  }
}

abstract class _GetPostFailure implements PostState {
  const factory _GetPostFailure(PostFailure failure) = _$_GetPostFailure;

  PostFailure get failure => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$GetPostFailureCopyWith<_GetPostFailure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$DeleteFailureCopyWith<$Res> {
  factory _$DeleteFailureCopyWith(
          _DeleteFailure value, $Res Function(_DeleteFailure) then) =
      __$DeleteFailureCopyWithImpl<$Res>;
  $Res call({PostFailure failure});

  $PostFailureCopyWith<$Res> get failure;
}

/// @nodoc
class __$DeleteFailureCopyWithImpl<$Res> extends _$PostStateCopyWithImpl<$Res>
    implements _$DeleteFailureCopyWith<$Res> {
  __$DeleteFailureCopyWithImpl(
      _DeleteFailure _value, $Res Function(_DeleteFailure) _then)
      : super(_value, (v) => _then(v as _DeleteFailure));

  @override
  _DeleteFailure get _value => super._value as _DeleteFailure;

  @override
  $Res call({
    Object? failure = freezed,
  }) {
    return _then(_DeleteFailure(
      failure == freezed
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as PostFailure,
    ));
  }

  @override
  $PostFailureCopyWith<$Res> get failure {
    return $PostFailureCopyWith<$Res>(_value.failure, (value) {
      return _then(_value.copyWith(failure: value));
    });
  }
}

/// @nodoc

class _$_DeleteFailure implements _DeleteFailure {
  const _$_DeleteFailure(this.failure);

  @override
  final PostFailure failure;

  @override
  String toString() {
    return 'PostState.deleteFailure(failure: $failure)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _DeleteFailure &&
            (identical(other.failure, failure) ||
                const DeepCollectionEquality().equals(other.failure, failure)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(failure);

  @JsonKey(ignore: true)
  @override
  _$DeleteFailureCopyWith<_DeleteFailure> get copyWith =>
      __$DeleteFailureCopyWithImpl<_DeleteFailure>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Post> posts) readSuccess,
    required TResult Function(PostFailure failure) readFailure,
    required TResult Function(Post post, User user) getPostSuccess,
    required TResult Function(PostFailure failure) getPostFailure,
    required TResult Function(PostFailure failure) deleteFailure,
    required TResult Function() deleteSuccess,
  }) {
    return deleteFailure(failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Post> posts)? readSuccess,
    TResult Function(PostFailure failure)? readFailure,
    TResult Function(Post post, User user)? getPostSuccess,
    TResult Function(PostFailure failure)? getPostFailure,
    TResult Function(PostFailure failure)? deleteFailure,
    TResult Function()? deleteSuccess,
    required TResult orElse(),
  }) {
    if (deleteFailure != null) {
      return deleteFailure(failure);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_ReadSuccess value) readSuccess,
    required TResult Function(_ReadFailure value) readFailure,
    required TResult Function(_GetPostSuccess value) getPostSuccess,
    required TResult Function(_GetPostFailure value) getPostFailure,
    required TResult Function(_DeleteFailure value) deleteFailure,
    required TResult Function(_DeleteSuccess value) deleteSuccess,
  }) {
    return deleteFailure(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_ReadSuccess value)? readSuccess,
    TResult Function(_ReadFailure value)? readFailure,
    TResult Function(_GetPostSuccess value)? getPostSuccess,
    TResult Function(_GetPostFailure value)? getPostFailure,
    TResult Function(_DeleteFailure value)? deleteFailure,
    TResult Function(_DeleteSuccess value)? deleteSuccess,
    required TResult orElse(),
  }) {
    if (deleteFailure != null) {
      return deleteFailure(this);
    }
    return orElse();
  }
}

abstract class _DeleteFailure implements PostState {
  const factory _DeleteFailure(PostFailure failure) = _$_DeleteFailure;

  PostFailure get failure => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$DeleteFailureCopyWith<_DeleteFailure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$DeleteSuccessCopyWith<$Res> {
  factory _$DeleteSuccessCopyWith(
          _DeleteSuccess value, $Res Function(_DeleteSuccess) then) =
      __$DeleteSuccessCopyWithImpl<$Res>;
}

/// @nodoc
class __$DeleteSuccessCopyWithImpl<$Res> extends _$PostStateCopyWithImpl<$Res>
    implements _$DeleteSuccessCopyWith<$Res> {
  __$DeleteSuccessCopyWithImpl(
      _DeleteSuccess _value, $Res Function(_DeleteSuccess) _then)
      : super(_value, (v) => _then(v as _DeleteSuccess));

  @override
  _DeleteSuccess get _value => super._value as _DeleteSuccess;
}

/// @nodoc

class _$_DeleteSuccess implements _DeleteSuccess {
  const _$_DeleteSuccess();

  @override
  String toString() {
    return 'PostState.deleteSuccess()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _DeleteSuccess);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Post> posts) readSuccess,
    required TResult Function(PostFailure failure) readFailure,
    required TResult Function(Post post, User user) getPostSuccess,
    required TResult Function(PostFailure failure) getPostFailure,
    required TResult Function(PostFailure failure) deleteFailure,
    required TResult Function() deleteSuccess,
  }) {
    return deleteSuccess();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Post> posts)? readSuccess,
    TResult Function(PostFailure failure)? readFailure,
    TResult Function(Post post, User user)? getPostSuccess,
    TResult Function(PostFailure failure)? getPostFailure,
    TResult Function(PostFailure failure)? deleteFailure,
    TResult Function()? deleteSuccess,
    required TResult orElse(),
  }) {
    if (deleteSuccess != null) {
      return deleteSuccess();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_ReadSuccess value) readSuccess,
    required TResult Function(_ReadFailure value) readFailure,
    required TResult Function(_GetPostSuccess value) getPostSuccess,
    required TResult Function(_GetPostFailure value) getPostFailure,
    required TResult Function(_DeleteFailure value) deleteFailure,
    required TResult Function(_DeleteSuccess value) deleteSuccess,
  }) {
    return deleteSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_ReadSuccess value)? readSuccess,
    TResult Function(_ReadFailure value)? readFailure,
    TResult Function(_GetPostSuccess value)? getPostSuccess,
    TResult Function(_GetPostFailure value)? getPostFailure,
    TResult Function(_DeleteFailure value)? deleteFailure,
    TResult Function(_DeleteSuccess value)? deleteSuccess,
    required TResult orElse(),
  }) {
    if (deleteSuccess != null) {
      return deleteSuccess(this);
    }
    return orElse();
  }
}

abstract class _DeleteSuccess implements PostState {
  const factory _DeleteSuccess() = _$_DeleteSuccess;
}
