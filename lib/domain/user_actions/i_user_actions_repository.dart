import 'package:dartz/dartz.dart';
import 'package:flutter_share/domain/posts/post.dart';
import 'package:flutter_share/domain/user_actions/profile.dart';
import 'package:flutter_share/domain/user_actions/user_actions_failure.dart';

abstract class IUserActionsRepository {
  Future<Either<UserActionsFailure, Profile>> fetchProfile(String userId);
  Future<Option<UserActionsFailure>> likePost(Post post);
  Future<Option<UserActionsFailure>> followProfile(bool isfollowing, String userId);
}
