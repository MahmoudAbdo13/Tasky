class ProfileEntity {
  String id_;
  String displayName_;
  String username_;
  List<String> roles_;
  bool active_;
  int experienceYears_;
  String address_;
  String level_;
  DateTime createdAt_;
  DateTime updatedAt_;
  int v_;

  ProfileEntity({
    required this.id_,
    required this.displayName_,
    required this.username_,
    required this.roles_,
    required this.active_,
    required this.experienceYears_,
    required this.address_,
    required this.level_,
    required this.createdAt_,
    required this.updatedAt_,
    required this.v_,
  });

}
