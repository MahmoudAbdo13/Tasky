import 'package:dartz/dartz.dart';
import 'package:tasky/features/profile/domain/repo/profile_repo.dart';

import '../../../../core/failure.dart';
import '../entity/profile_entity.dart';

class ProfileUseCase {
  ProfileRepo profileRepo;
  ProfileUseCase(this.profileRepo);

  Future<Either<Failure, ProfileEntity>> getProfile() {
    return profileRepo.getProfile();
  }
}
