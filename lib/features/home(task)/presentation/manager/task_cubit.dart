import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasky/features/home(task)/domain/entities/image_entity.dart';
import 'package:tasky/features/home(task)/domain/use_cases/home_use_case.dart';

import '../../../../constant.dart';
import '../../../../core/failure.dart';
import '../../../../core/utils/app_manager/app_reference.dart';
import '../../domain/entities/task_entity.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit(this.homeUseCase) : super(TaskInitial());
  static TaskCubit getCubit(context) => BlocProvider.of(context);
  final HomeUseCase homeUseCase;
  String currentTap = 'All';
  void changeTap(String value) {
    currentTap = value;
    emit(ChangeTapState());
  }

  logout(String token) async {
    var res = await homeUseCase.logout(token);
    res.fold((failure) {
      emit(LogoutErrorState(failure));
    }, (success) {
      emit(LogoutSuccessState());
    });
  }

  List<TaskEntity> tasks = [];
  List<TaskEntity> waitingTasks = [];
  List<TaskEntity> completedTasks = [];
  List<TaskEntity> inProgressTasks = [];
  getTasks(int page) async {
    tasks = [];
    waitingTasks = [];
    completedTasks = [];
    inProgressTasks = [];
    var res = await homeUseCase.getTasks(page);
    res.fold((failure) {
      emit(GetTasksErrorState(failure));
    }, (success) {
      for (var element in success) {
        if (element.status_ == 'waiting') {
          waitingTasks.add(element);
        } else if (element.status_ == 'inProgress') {
          inProgressTasks.add(element);
        } else if (element.status_ == 'finished') {
          completedTasks.add(element);
        }
      }
      tasks.addAll(success);
      emit(GetTasksSuccessState());
    });
  }

  final priority = {'Low Priority', 'Medium Priority', 'High Priority'};
  String selectedPriority = 'Medium Priority';
  String editedPriority = '';
  choosePriority(String priority) {
    selectedPriority = priority;
    editedPriority = priority;
    emit(PriorityChanged());
  }
  final status = {'Waiting', 'Inprogress', 'Finished'};
  String selectedStatus = 'Waiting';
  chooseStatus(String status) {
    selectedStatus = status;
    emit(StatusChanged());
  }

  var picker = ImagePicker();
  File? taskImage;
  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      taskImage = File(pickedFile.path);
      emit(PickImageSuccessState());
      await uploadImage(taskImage!);
    } else {
      emit(PickImageErrorState());
    }
  }

  ImageEntity? imageEntity;
  uploadImage(File file) async {
    emit(UploadImageLoadingState());
    var res = await homeUseCase.uploadImage(file);
    res.fold((failure) {
      emit(UploadImageErrorState(failure));
    }, (success) {
      imageEntity = success;
      emit(UploadImageSuccessState());
    });
  }

  addTask(
    String title,
    String description,
    String date,
    String priority,
  ) async {
    emit(AddTaskLoadingState());
    var res = await homeUseCase.addTask(
        title, description, date, imageEntity!.image_, priority);
    res.fold((failure) {
      emit(AddTaskErrorState(failure));
    }, (success) {
      emit(AddTaskSuccessState());
    });
  }

  deleteTask(String id) async {
    emit(DeleteTaskLoadingState());
    var res = await homeUseCase.deleteTask(id);
    res.fold((failure) {
      emit(DeleteTaskErrorState(failure));
    }, (success) {
      emit(DeleteTaskSuccessState());
    });
  }

  editTask(String id, String title, String description, String priority,String status,String user,String image) async {
    emit(EditTaskLoadingState());
    var res = await homeUseCase.editTask(id, title, description,status, priority,image,user);
    res.fold((failure) {
      emit(EditTaskErrorState(failure));
    }, (success) {
      emit(EditTaskSuccessState());
    });
  }

  TaskEntity? oneTask;
  getOneTask(String id) async {
    emit(GetOneTaskLoadingState());
    var res = await homeUseCase.getOneTask(id);
    res.fold((failure) {
      emit(GetOneTaskErrorState(failure));
    }, (success) {
      oneTask = success;
      emit(GetOneTaskSuccessState(oneTask!,));
    });
  }

  refreshToken(String refreshToken) async {
    emit(RefreshTokenLoadingState());
    var res = await homeUseCase.refreshToken(refreshToken);
    res.fold((failure) {
      emit(RefreshTokenErrorState(failure));
    }, (success) {
      AppReference.setData(key: userToken, data: success.accessToken_,);
      emit(RefreshTokenSuccessState());
    });
  }

}
