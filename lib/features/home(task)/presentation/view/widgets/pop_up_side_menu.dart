import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tasky/core/utils/app_manager/app_color.dart';
import 'package:tasky/core/utils/app_manager/app_styles.dart';
import 'package:tasky/core/utils/functions/go_next.dart';
import 'package:tasky/features/home(task)/domain/entities/task_entity.dart';

import '../../../../../core/utils/app_manager/app_routes.dart';
import '../../../../../core/widgets/loading_dialog.dart';
import '../../manager/task_cubit.dart';

class PopupMenuView extends StatelessWidget {
  const PopupMenuView({super.key, required this.taskEntity});
  final TaskEntity taskEntity;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskCubit, TaskState>(
      listener: (context, state) {
        if (state is DeleteTaskSuccessState) {
          Navigator.pop(context);
          showSnackBar(context: context, message: 'Task deleted successfully');
          TaskCubit.getCubit(context).getTasks(1);
          GoRouter.of(context).pop('tasks details');
        }
      },
      builder: (context, state) {
        var cubit = TaskCubit.getCubit(context);
        return Center(
          child: PopupMenuButton<String>(
            menuPadding: EdgeInsets.zero,
            position: PopupMenuPosition.under,
            color: AppColor.whiteColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 4,
            popUpAnimationStyle: AnimationStyle(curve: Curves.bounceInOut),
            icon: Icon(
              Icons.more_vert,
              color: AppColor.blackColor,
              size: 24,
            ),
            // Three-dot icon
            onSelected: (String value) {
              if (value == 'Edit') {
                GoRouter.of(context)
                    .push(Routes.newTaskRoute, extra: taskEntity);
              } else if (value == 'Delete') {
                showProgressDialog(context);
                cubit.deleteTask(taskEntity.id_);
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                padding: EdgeInsets.only(top: 15, left: 15, right: 15),
                height: 35,
                value: 'Edit',
                child: Text(
                  'Edit',
                  style: Styles.textStyle16,
                ),
              ),
              PopupMenuItem<String>(
                padding: const EdgeInsets.all(15),
                height: 35,
                value: 'Delete',
                child: Text(
                  'Delete',
                  style:
                      Styles.textStyle16.copyWith(color: AppColor.orangeColor),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
