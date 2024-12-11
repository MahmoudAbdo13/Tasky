import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:tasky/features/home(task)/domain/entities/logout_entity.dart';
import 'package:tasky/features/home(task)/domain/entities/token_entity.dart';
import 'package:tasky/features/home(task)/domain/repo/home_repo.dart';

import '../../../../core/failure.dart';
import '../entities/image_entity.dart';
import '../entities/task_entity.dart';

class HomeUseCase {
  final HomeRepo homeRepo;

  HomeUseCase(this.homeRepo);
  Future<Either<Failure, LogoutEntity>> logout(String token) {
    return homeRepo.logout(token);
  }

  Future<Either<Failure, List<TaskEntity>>> getTasks(int page){
    return homeRepo.getTasks(page);
  }

  Future<Either<Failure, TaskEntity>> addTask(String title, String description,String date,String image,String priority) {
    return homeRepo.addTask(title, description, date, priority, image);
  }

  Future<Either<Failure, ImageEntity>> uploadImage(File file) {
    return homeRepo.uploadImage(file);
  }


  Future<Either<Failure, String>> deleteTask(String id) {
    return homeRepo.deleteTask(id);
  }


  Future<Either<Failure, TaskEntity>> getOneTask(String id) {
    return homeRepo.getOneTask(id);
  }


  Future<Either<Failure, String>> editTask(String id,String title, String description, String status, String priority, String image,String user) {
    return homeRepo.editTask(id,title, description, status, priority, image,user);
  }

  Future<Either<Failure, TokenEntity>> refreshToken(String refreshToken) {
    return homeRepo.refreshToken(refreshToken);
  }

}