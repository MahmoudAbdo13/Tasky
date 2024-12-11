import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tasky/core/failure.dart';
import 'package:tasky/features/profile/data/data_source/profile_remote_data_source.dart';
import 'package:tasky/features/profile/domain/entity/profile_entity.dart';
import 'package:tasky/features/profile/domain/repo/profile_repo.dart';

class ProfileRepoImpl extends ProfileRepo{
  final ProfileRemoteDataSource profileRemoteDataSource;
  ProfileRepoImpl(this.profileRemoteDataSource);

  @override
  Future<Either<Failure, ProfileEntity>> getProfile() async {
    try{
      ProfileEntity  profileEntity = await profileRemoteDataSource.getProfile();
      return right(profileEntity);
    } on Exception catch(e){
      if(e is DioException){
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }

  }

}