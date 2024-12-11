
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/failure.dart';
import '../../domain/entity/auth_entity.dart';
import '../../domain/repo/auth_repo.dart';
import '../data_source/auth_remote_data_source.dart';

class AuthRepoImpl extends AuthRepo {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepoImpl(this.authRemoteDataSource);
  @override
  Future<Either<Failure, AuthEntity>> login(
      String phone, String password) async {
    try {
      AuthEntity loginEntity;
      loginEntity = await authRemoteDataSource.login(phone, password);
      return Right(loginEntity);
    } on Exception catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthEntity>> register(String name, String phoneNumber, int experienceYears, String password, String address, String level) async {
    try {
      AuthEntity registerEntity;
      registerEntity = await authRemoteDataSource.register(name,phoneNumber,experienceYears,password,address,level);
      return Right(registerEntity);
    } on Exception catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
