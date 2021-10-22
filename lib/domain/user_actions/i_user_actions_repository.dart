import 'package:dartz/dartz.dart';
import 'package:flutter_share/domain/auth/user.dart';

import 'package:flutter_share/domain/posts/post.dart';
import 'package:flutter_share/domain/user_actions/comment.dart';
import 'package:flutter_share/domain/user_actions/profile.dart';
import 'package:flutter_share/domain/user_actions/user_actions_failure.dart';

abstract class IUserActionsRepository {
  Future<Either<UserActionsFailure, Profile>> fetchProfile(
    String userId,
    String currentUserId,
  );
  Future<Option<UserActionsFailure>> likePost(Post post, User currentUser);
  Future<Option<UserActionsFailure>> followProfile(
    bool isfollowing,
    String userId,
    User currentUser,
  );
  Stream<Either<UserActionsFailure, List<Comment>>> fetchComments(
    String postId,
  );
  Future<Option<UserActionsFailure>> editProfile(User user);
}
