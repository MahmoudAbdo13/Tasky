import 'dart:io';
import 'package:tasky/constant.dart';
import 'package:tasky/core/utils/app_manager/app_reference.dart';
import 'package:tasky/features/home(task)/data/models/logout_model.dart';
import 'package:tasky/features/home(task)/domain/entities/image_entity.dart';
import 'package:tasky/features/home(task)/domain/entities/logout_entity.dart';
import '../../../../core/utils/api_services.dart';
import '../../domain/entities/task_entity.dart';
import '../../domain/entities/token_entity.dart';
import '../models/image_model.dart';
import '../models/task_model.dart';
import '../models/token_model.dart';

abstract class HomeRemoteDataSource {
  Future<LogoutEntity> logout(String token);
  Future<List<TaskEntity>> getTasks(int page);
  Future<TaskEntity> addTask(String title, String description, String date,
      String priority, String image);
  Future<ImageEntity> uploadImage(File file);
  Future<String> editTask(String id, String title, String description,
      String status, String priority, String image, String user);
  Future<String> deleteTask(String id);
  Future<TaskEntity> getOneTask(String id);
  Future<TokenEntity> refreshToken(String refreshToken);
}

class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  final ApiService apiService;

  HomeRemoteDataSourceImpl(this.apiService);

  @override
  Future<LogoutEntity> logout(String token) async {
    var res = await apiService.post(
        userToken: AppReference.getData(key: userToken),
        endPoint: logoutEndPoint,
        data: {
          "token": token,
        });
    LogoutEntity logoutEntity = LogoutModel.fromJson(res);
    return logoutEntity;
  }

  @override
  Future<List<TaskEntity>> getTasks(int page) async {
    var res = await apiService.get(
        userToken: AppReference.getData(key: userToken),
        endPoint: tasksEndPoint,
        page: page);
    List<TaskEntity> tasks = [];
    print('==================${res.toString()}');
    for (var element in res.data) {
      print('==================${element.toString()}');
      tasks.add(TaskModel.fromJson(element));
    }
    return tasks;
  }

  @override
  Future<TaskEntity> addTask(String title, String description, String date,
      String priority, String image) async {
    var res = await apiService.post(
        userToken: AppReference.getData(key: userToken),
        endPoint: tasksEndPoint,
        data: {
          "title": title,
          "desc": description,
          "dueDate": date,
          "priority": priority,
          "image": image,
        });
    TaskEntity taskEntity = TaskModel.fromJson(res);
    return taskEntity;
  }

  @override
  Future<ImageEntity> uploadImage(File file) async {
    var res = await apiService.postImage(
      file: file,
      userToken: AppReference.getData(key: userToken),
      endPoint: uploadImageEndPoint,
    );
    print('=================status${res.toString()}');
    ImageEntity imageEntity = ImageModel.fromJson(res);
    print('=================status${res.toString()}');
    return imageEntity;
  }

  @override
  Future<String> deleteTask(String id) async {
    var res = await apiService.delete(
      userToken: AppReference.getData(key: userToken),
      endPoint: '$tasksEndPoint/$id',
    );
    return res.toString();
  }

  @override
  Future<String> editTask(String id, String title, String description,
      String status, String priority, String image, String user) async {
    var res = await apiService.put(
        userToken: AppReference.getData(key: userToken),
        endPoint: '$tasksEndPoint/$id',
        data: {
          "image": image,
          "title": title,
          "desc": description,
          "priority": priority,
          "status": status,
          "user": user
        });
   return res.toString();
  }

  @override
  Future<TaskEntity> getOneTask(String id) async {
    var res = await apiService.get(
      userToken: AppReference.getData(key: userToken),
      endPoint: '$tasksEndPoint/$id',
    );
    TaskEntity taskEntity = TaskModel.fromJson(res.data);
    return taskEntity;
  }

  @override
  Future<TokenEntity> refreshToken(String refreshToken) async {
    var res = await apiService.get(
        userToken: AppReference.getData(key: userToken),
        endPoint: refreshTokenEndPoint + refreshToken);
    TokenEntity tokenEntity = TokenModel.fromJson(res.data);
    return tokenEntity;
  }
}
