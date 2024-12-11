import 'package:tasky/features/profile/domain/entity/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  String id;
  String displayName;
  String username;
  List<String> roles;
  bool active;
  int experienceYears;
  String address;
  String level;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  ProfileModel({
    required this.id,
    required this.displayName,
    required this.username,
    required this.roles,
    required this.active,
    required this.experienceYears,
    required this.address,
    required this.level,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  }) : super(
            active_: active,
            address_: address,
            createdAt_: createdAt,
            displayName_: displayName,
            experienceYears_: experienceYears,
            id_: id,
            level_: level,
            roles_: roles,
            updatedAt_: updatedAt,
            username_: username,
            v_: v);

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        id: json["_id"],
        displayName: json["displayName"],
        username: json["username"],
        roles: List<String>.from(json["roles"].map((x) => x)),
        active: json["active"],
        experienceYears: json["experienceYears"],
        address: json["address"],
        level: json["level"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );
}
