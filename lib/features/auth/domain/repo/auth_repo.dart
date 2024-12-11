import 'package:dartz/dartz.dart';
import 'package:tasky/features/auth/domain/entity/auth_entity.dart';

import '../../../../core/failure.dart';

abstract class AuthRepo {
  Future<Either<Failure, AuthEntity>> login(String phone, String password);
  Future<Either<Failure, AuthEntity>> register(
      String name, String phoneNumber, int experienceYears, String password,String address,String level);
}