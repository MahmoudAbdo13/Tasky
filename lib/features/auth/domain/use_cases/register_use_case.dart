import 'package:dartz/dartz.dart';
import 'package:tasky/features/auth/domain/entity/auth_entity.dart';

import '../../../../core/failure.dart';
import '../repo/auth_repo.dart';

class RegisterUseCase {
  final AuthRepo authRepo;

  RegisterUseCase(this.authRepo);

  Future<Either<Failure, AuthEntity>> register(
      String name, String phoneNumber, int experienceYears, String password,String level,String address) {
    return authRepo.register(name,phoneNumber,experienceYears,password,address,level);
  }
}