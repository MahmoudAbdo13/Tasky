import 'package:tasky/features/home(task)/domain/entities/token_entity.dart';

class TokenModel extends TokenEntity {
  String accessToken;

  TokenModel({
    required this.accessToken,
  }) : super(accessToken_: accessToken);

  factory TokenModel.fromJson(Map<String, dynamic> json) => TokenModel(
    accessToken: json["access_token"],
  );
}
