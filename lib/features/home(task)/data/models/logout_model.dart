import 'package:tasky/features/home(task)/domain/entities/logout_entity.dart';

class LogoutModel extends LogoutEntity {
  bool? success;

  LogoutModel({this.success}): super(success_: success);

  factory LogoutModel.fromJson(Map<String, dynamic> json) => LogoutModel(
      success : json['success'],
  );
}