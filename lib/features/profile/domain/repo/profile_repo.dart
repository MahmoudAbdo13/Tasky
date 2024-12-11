import 'package:dartz/dartz.dart';
import 'package:tasky/features/profile/domain/entity/profile_entity.dart';

import '../../../../core/failure.dart';

abstract class ProfileRepo{
  Future<Either<Failure, ProfileEntity>> getProfile();
}