import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tasky/core/widgets/no_data_widget.dart';
import 'package:tasky/features/home(task)/presentation/manager/task_cubit.dart';
import 'package:tasky/features/home(task)/presentation/view/widgets/task_list_view_item.dart';

import '../../../../../core/utils/app_manager/app_routes.dart';

class AllTasksViewTab extends StatelessWidget {
  const AllTasksViewTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskCubit, TaskState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = TaskCubit.getCubit(context);
        return state is !GetTasksLoadingState
            ? cubit.tasks.isEmpty
                ? const EmptyListComponent()
                : Expanded(
                    child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              Object? refresh = GoRouter.of(context).push(
                                  Routes.taskDetailsRoute,
                                  extra: cubit.tasks[index]);
                              if (refresh == 'tasks details') {
                                cubit.getTasks(1);
                              }
                            },
                            child: TaskListViewItem(
                              task: cubit.tasks[index],
                            )),
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 10,
                            ),
                        itemCount: cubit.tasks.length),
                  )
            : const Expanded(
                child: Center(
                child: CircularProgressIndicator(),
              ));
      },
    );
  }
}
