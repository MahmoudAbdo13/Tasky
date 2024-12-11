import 'package:tasky/features/home(task)/domain/entities/task_entity.dart';

class TaskModel extends TaskEntity {
  String id;
  String image;
  String title;
  String desc;
  String priority;
  String status;
  String user;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  TaskModel({
    required this.id,
    required this.image,
    required this.title,
    required this.desc,
    required this.priority,
    required this.status,
    required this.user,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  }) : super(
          v_: v,
          updatedAt_: updatedAt,
          id_: id,
          createdAt_: createdAt,
          desc_: desc,
          image_: image,
          priority_: priority,
          status_: status,
          title_: title,
          user_: user,
        );

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        id: json["_id"],
        image: json["image"],
        title: json["title"],
        desc: json["desc"],
        priority: json["priority"],
        status: json["status"],
        user: json["user"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "image": image,
        "title": title,
        "desc": desc,
        "priority": priority,
        "status": status,
        "user": user,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
