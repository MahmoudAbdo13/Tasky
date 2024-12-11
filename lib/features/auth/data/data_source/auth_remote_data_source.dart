import 'package:tasky/core/utils/app_manager/app_reference.dart';
import 'package:tasky/features/auth/data/models/aurh_model.dart';
import 'package:tasky/features/auth/domain/entity/auth_entity.dart';

import '../../../../constant.dart';
import '../../../../core/utils/api_services.dart';

abstract class AuthRemoteDataSource {
  Future<AuthEntity> login(String number, String password);
  Future<AuthEntity> register(String name, String phoneNumber,
      int experienceYears, String password, String address, String level);
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final ApiService apiService;

  AuthRemoteDataSourceImpl(this.apiService);

  @override
  Future<AuthEntity> login(String number, String password) async {
    var res = await apiService.post(
        endPoint: loginEndPoint,
        data: {"phone": number, "password": password});
    AuthEntity? loginEntity = AuthModel.fromJson(res);
    AppReference.setData(key: userToken, data: loginEntity.accessToken_.toString());
    AppReference.setData(key: refreshToken, data: loginEntity.refreshToken_.toString());
    AppReference.setData(key: userID, data: loginEntity.sId_.toString());
    return loginEntity;
  }

  @override
  Future<AuthEntity> register(
      String name,
      String phoneNumber,
      int experienceYears,
      String password,
      String address,
      String level) async {
    var res = await apiService.post(
        endPoint: registerEndPoint,
        data: {
      "phone": phoneNumber,
      "password": password,
      'displayName': name,
      "experienceYears": experienceYears,
      "address": address,
      "level": level
    });
    AuthEntity? registerEntity = AuthModel.fromJson(res);
    AppReference.setData(key: userToken, data: registerEntity.accessToken_.toString());
    AppReference.setData(key: refreshToken, data: registerEntity.refreshToken_.toString());
    AppReference.setData(key: userID, data: registerEntity.sId_.toString());
    return registerEntity;
  }
}
