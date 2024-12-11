part of 'task_cubit.dart';

abstract class TaskState {}

final class TaskInitial extends TaskState {}

final class ChangeTapState extends TaskState {}

final class LogoutSuccessState extends TaskState {}

final class LogoutErrorState extends TaskState {
  final Failure failure;
  LogoutErrorState(this.failure);
}

final class GetTasksLoadingState extends TaskState {}

final class GetTasksSuccessState extends TaskState {}

final class GetTasksErrorState extends TaskState {
  final Failure failure;
  GetTasksErrorState(this.failure);
}

final class PriorityChanged extends TaskState {}

final class PickImageSuccessState extends TaskState {}

final class PickImageErrorState extends TaskState {}

final class UploadImageLoadingState extends TaskState {}

final class UploadImageSuccessState extends TaskState {}

final class UploadImageErrorState extends TaskState {
  final Failure failure;
  UploadImageErrorState(this.failure);
}

final class AddTaskLoadingState extends TaskState {}

final class AddTaskSuccessState extends TaskState {}

final class AddTaskErrorState extends TaskState {
  final Failure failure;
  AddTaskErrorState(this.failure);
}

final class StatusChanged extends TaskState {}

final class DeleteTaskLoadingState extends TaskState {}

final class DeleteTaskSuccessState extends TaskState {}

final class DeleteTaskErrorState extends TaskState {
  final Failure failure;
  DeleteTaskErrorState(this.failure);
}

final class EditTaskLoadingState extends TaskState {}

final class EditTaskSuccessState extends TaskState {}

final class EditTaskErrorState extends TaskState {
  final Failure failure;
  EditTaskErrorState(this.failure);
}

final class GetOneTaskLoadingState extends TaskState {}

final class GetOneTaskSuccessState extends TaskState {
  final TaskEntity task;
  GetOneTaskSuccessState(this.task);
}

final class GetOneTaskErrorState extends TaskState {
  final Failure failure;
  GetOneTaskErrorState(this.failure);
}

final class RefreshTokenLoadingState extends TaskState {}

final class RefreshTokenSuccessState extends TaskState {}

final class RefreshTokenErrorState extends TaskState {
  final Failure failure;
  RefreshTokenErrorState(this.failure);
}
