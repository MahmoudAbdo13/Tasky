import 'package:tasky/features/auth/domain/entity/auth_entity.dart';

class AuthModel extends AuthEntity{
  String? sId;
  String? displayName;
  String? accessToken;
  String? refreshToken;

  AuthModel({this.sId, this.displayName, this.accessToken, this.refreshToken}
      ) : super(accessToken_: accessToken,refreshToken_: refreshToken,sId_: sId);

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
      sId : json['_id'],
      displayName : json['displayName'],
      accessToken :json['access_token'],
      refreshToken : json['refresh_token']
  );
}