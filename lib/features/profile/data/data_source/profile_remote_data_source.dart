import 'package:tasky/constant.dart';
import 'package:tasky/core/utils/api_services.dart';
import 'package:tasky/core/utils/app_manager/app_reference.dart';
import 'package:tasky/features/profile/data/model/profile_model.dart';

import '../../domain/entity/profile_entity.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileEntity> getProfile();
}

class ProfileRemoteDataSourceImpl extends ProfileRemoteDataSource {
  final ApiService apiService;
  ProfileRemoteDataSourceImpl(this.apiService);

  @override
  Future<ProfileEntity> getProfile() async {
    var res = await apiService.get(
        endPoint: profileEndPoint,
        userToken: AppReference.getData(key: userToken),
    );
    ProfileEntity profileEntity = ProfileModel.fromJson(res.data);
    return profileEntity;
  }
}
