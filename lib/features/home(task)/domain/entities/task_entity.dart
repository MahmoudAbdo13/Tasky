class TaskEntity {
  String id_;
  String image_;
  String title_;
  String desc_;
  String priority_;
  String status_;
  String user_;
  DateTime createdAt_;
  DateTime updatedAt_;
  int v_;

  TaskEntity({
    required this.id_,
    required this.image_,
    required this.title_,
    required this.desc_,
    required this.priority_,
    required this.status_,
    required this.user_,
    required this.createdAt_,
    required this.updatedAt_,
    required this.v_,
  });

}
