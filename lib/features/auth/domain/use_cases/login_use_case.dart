import 'package:dartz/dartz.dart';

import '../../../../core/failure.dart';
import '../entity/auth_entity.dart';
import '../repo/auth_repo.dart';


class LoginUseCase {
  final AuthRepo authRepo;

  LoginUseCase(this.authRepo);
  Future<Either<Failure, AuthEntity>> login(String phone, String password) {
    return authRepo.login(phone, password);
  }
}