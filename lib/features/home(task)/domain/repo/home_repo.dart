import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:tasky/features/home(task)/domain/entities/image_entity.dart';
import 'package:tasky/features/home(task)/domain/entities/logout_entity.dart';
import 'package:tasky/features/home(task)/domain/entities/token_entity.dart';

import '../../../../core/failure.dart';
import '../entities/task_entity.dart';

abstract class HomeRepo {
  Future<Either<Failure, LogoutEntity>> logout(String token);
  Future<Either<Failure, List<TaskEntity>>> getTasks( int page);
  Future<Either<Failure, ImageEntity>> uploadImage(File file);
  Future<Either<Failure, TaskEntity>> addTask(String title, String description, String date, String priority, String image);
  Future<Either<Failure, String>> editTask(String id,String title, String description, String status, String priority, String image,String user);
  Future<Either<Failure, String>> deleteTask(String id);
  Future<Either<Failure, TaskEntity>> getOneTask(String id);
  Future<Either<Failure, TokenEntity>> refreshToken(String refreshToken);

}