import 'package:dartz/dartz.dart';
import 'package:flutter_share/domain/user_actions.dart/profile.dart';
import 'package:flutter_share/domain/user_actions.dart/user_actions_failure.dart';

abstract class IUserActionsRepository {
  Future<Either<UserActionsFailure, Profile>> fetchProfile(String userId);
}
