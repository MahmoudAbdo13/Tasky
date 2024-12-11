import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tasky/core/failure.dart';
import 'package:tasky/features/home(task)/data/data_source/home_remote_data_source.dart';
import 'package:tasky/features/home(task)/domain/entities/image_entity.dart';
import 'package:tasky/features/home(task)/domain/entities/logout_entity.dart';
import 'package:tasky/features/home(task)/domain/entities/task_entity.dart';
import 'package:tasky/features/home(task)/domain/entities/token_entity.dart';
import 'package:tasky/features/home(task)/domain/repo/home_repo.dart';

class HomeRepoImpl extends HomeRepo {
  final HomeRemoteDataSource homeRemoteDataSource;
  HomeRepoImpl(this.homeRemoteDataSource);
  @override
  Future<Either<Failure, LogoutEntity>> logout(String token) async {
    try {
      LogoutEntity logoutEntity;
      logoutEntity = await homeRemoteDataSource.logout(token);
      return right(logoutEntity);
    } on Exception catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TaskEntity>>> getTasks(int page) async {
    try {
      List<TaskEntity> tasks;
      tasks = await homeRemoteDataSource.getTasks(page);
      return right(tasks);
    } on Exception catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TaskEntity>> addTask(String title, String description,
      String date, String priority, String image) async {
    try {
      TaskEntity taskEntity;
      taskEntity = await homeRemoteDataSource.addTask(
          title, description, date, priority, image);
      return right(taskEntity);
    } on Exception catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ImageEntity>> uploadImage(File file) async {
    try {
      ImageEntity imageEntity;
      imageEntity = await homeRemoteDataSource.uploadImage(file);
      return right(imageEntity);
    } on Exception catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> deleteTask(String id) async {
    try {
      String message;
      message = await homeRemoteDataSource.deleteTask(id);
      return right(message);
    } on Exception catch (e) {
      print('=====================delete ${e.toString()}');
      print('=====================delete ${e.runtimeType}');
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> editTask(
      String id,
      String title,
      String description,
      String status,
      String priority,
      String image,
      String user) async {
    try {
      String message;
      message = await homeRemoteDataSource.editTask(
          id, title, description, status, priority, image, user);
      return right(message);
    } on Exception catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TaskEntity>> getOneTask(String id) async {
    try {
      TaskEntity taskEntity;
      taskEntity = await homeRemoteDataSource.getOneTask(id);
      return right(taskEntity);
    } on Exception catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TokenEntity>> refreshToken(String refreshToken) async {
    try {
      TokenEntity tokenEntity;
      tokenEntity = await homeRemoteDataSource.refreshToken(refreshToken);
      return right(tokenEntity);
    } on Exception catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
