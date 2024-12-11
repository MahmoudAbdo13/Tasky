import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tasky/constant.dart';
import 'package:tasky/core/utils/functions/first_letter_cap.dart';
import 'package:tasky/core/utils/functions/go_next.dart';
import 'package:tasky/core/widgets/extension.dart';
import 'package:tasky/features/home(task)/domain/entities/task_entity.dart';
import 'package:tasky/features/home(task)/presentation/manager/task_cubit.dart';
import 'package:tasky/features/home(task)/presentation/view/widgets/pop_up_side_menu.dart';

import '../../../../core/utils/app_manager/app_assets.dart';
import '../../../../core/utils/app_manager/app_color.dart';
import '../../../../core/utils/app_manager/app_reference.dart';
import '../../../../core/utils/app_manager/app_styles.dart';
import '../../../../core/widgets/cached_image.dart';

class TaskDetailsView extends StatelessWidget {
  const TaskDetailsView({super.key, required this.taskEntity});
  final TaskEntity taskEntity;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocConsumer<TaskCubit, TaskState>(
      listener: (context, state) {
        if(state is DeleteTaskErrorState){
          if(state.failure.errorMessage == '401'){
            TaskCubit.getCubit(context).refreshToken(AppReference.getData(key: refreshToken));
          }
          showSnackBar(context: context, message: 'Ops! something went wrong, please try again');
        }
      },
      builder: (context, state) {
        var cubit = TaskCubit.getCubit(context);
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            backgroundColor: AppColor.whiteColor,
            title: const Text(
              'Task Details',
              style: Styles.textStyle16,
            ),
            leading: GestureDetector(
              onTap: () {
                GoRouter.of(context).pop('tasks details');
              },
              child: Image.asset(
                AssetsData.arrowLeft,
                width: 24,
                height: 24,
                color: AppColor.blackColor,
              ),
            ),
            actions: [
              PopupMenuView(taskEntity: taskEntity,)
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  cachedImage(
                    "$imageBaseUrl${taskEntity.image_}",
                    AssetsData.splashImage,
                    width: size.width,
                    height: size.width * .6,
                    radius: 12,
                  ),
                  10.height,
                  Text(
                    taskEntity.title_,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Styles.textStyle24.copyWith(
                      color: AppColor.blackColor,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  10.height,
                  Text(
                    taskEntity.desc_,
                    style: Styles.textStyle16.copyWith(
                      color: AppColor.grayColor,
                    ),
                  ),
                  10.height,
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColor.darkBlueOpacity,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'End Date',
                                  style: Styles.textStyle12.copyWith(
                                    color: AppColor.grayColor,
                                  ),
                                ),
                                3.height,
                                Text(
                                  DateFormat('d MMM, yyyy')
                                      .format(taskEntity.createdAt_),
                                  style: Styles.textStyle16.copyWith(
                                    color: AppColor.blackColor,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Image.asset(
                              AssetsData.calendarIcon,
                              width: 35,
                              height: 35,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  10.height,
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: AppColor.darkBlueOpacity,
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5),
                      child: DropdownButton<String>(
                        padding: const EdgeInsets.all(2),
                        style: Styles.textStyle16.copyWith(
                            color: AppColor.darkBlueColor,
                            fontWeight: FontWeight.bold),
                        value: cubit.selectedStatus == ''
                            ? formatText(taskEntity.status_)
                            : cubit.selectedStatus,
                        underline: const SizedBox(),
                        isExpanded: true,
                        icon: Image.asset(
                          AssetsData.arrowDown,
                          width: 24,
                          height: 20,
                          color: AppColor.darkBlueColor,
                        ),
                        hint: const Text(
                          "Choose Status...",
                          style: Styles.textStyle16,
                        ),
                        items: cubit.status
                            .map(
                              (item) => DropdownMenuItem(
                                value: item,
                                child: Text(
                                  item,
                                  style: Styles.textStyle16,
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          cubit.chooseStatus(value!);
                        },
                      ),
                    ),
                  ),
                  10.height,
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: AppColor.darkBlueOpacity,
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5),
                      child: Row(
                        children: [
                          Icon(
                            Icons.outlined_flag_rounded,
                            color: AppColor.darkBlueColor,
                            size: 30,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: DropdownButton<String>(
                              padding: const EdgeInsets.all(2),
                              style: Styles.textStyle16.copyWith(
                                  color: AppColor.darkBlueColor,
                                  fontWeight: FontWeight.bold),
                              value: cubit.editedPriority == ''
                                  ? '${formatText(taskEntity.priority_)} Priority'
                                  : cubit.editedPriority,
                              underline: const SizedBox(),
                              isExpanded: true,
                              icon: Image.asset(
                                AssetsData.arrowDown,
                                width: 24,
                                height: 20,
                                color: AppColor.darkBlueColor,
                              ),
                              hint: const Text(
                                "Choose priority...",
                                style: Styles.textStyle16,
                              ),
                              items: cubit.priority
                                  .map(
                                    (item) => DropdownMenuItem(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: Styles.textStyle16,
                                      ),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                cubit.choosePriority(value!);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  20.height,
                  Center(
                    child: QrImageView(
                      data: taskEntity.id_,
                      version: QrVersions.auto,
                      size: size.width * 0.8,
                      gapless: true,
                    ),
                  ),
                  50.height,
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
