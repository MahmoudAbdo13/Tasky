import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tasky/constant.dart';
import 'package:tasky/core/utils/app_manager/app_routes.dart';
import 'package:tasky/core/widgets/cached_image.dart';
import 'package:tasky/features/home(task)/domain/entities/task_entity.dart';

import '../../../../../core/utils/app_manager/app_assets.dart';
import '../../../../../core/utils/app_manager/app_color.dart';
import '../../../../../core/utils/app_manager/app_styles.dart';
import '../../../../../core/utils/functions/first_letter_cap.dart';

class TaskListViewItem extends StatelessWidget {
  const TaskListViewItem({
    super.key,
    required this.task,
  });
  final TaskEntity task;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        cachedImage(
            '$imageBaseUrl${task.image_}',
            AssetsData.splashImage,
          width: size.width * .23,
          height: size.width * .23,
          radius: 12
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  task.title_,
                  style: Styles.textStyle16.copyWith(height: 2),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                      color: task.status_ == 'waiting'
                          ? AppColor.orangeOpacityColor
                          : task.status_ == 'finished'
                              ? AppColor.lightBlueOpacityColor
                              : AppColor.darkBlueOpacity,
                      borderRadius: BorderRadius.circular(8)),
                  child: Text(
                    formatText(task.status_),
                    style: Styles.textStyle12.copyWith(
                        color: task.status_ == 'waiting'
                            ? AppColor.orangeColor
                            : task.status_ == 'finished'
                                ? AppColor.lightBlueColor
                                : AppColor.darkBlueColor),
                  ),
                )
              ],
            ),
            Text(
              task.desc_,
              style: Styles.textStyle14.copyWith(color: AppColor.grayColor),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            Row(
              children: [
                Icon(
                  Icons.outlined_flag_rounded,
                  size: 24,
                  color: task.priority_ == 'high'
                      ? AppColor.orangeColor
                      : task.priority_ == 'medium'
                          ? AppColor.darkBlueColor
                          : AppColor.lightBlueColor,
                ),
                const SizedBox(
                  width: 3,
                ),
                Text(
                  formatText(task.priority_),
                  style: Styles.textStyle12.copyWith(
                      color: task.priority_ == 'high'
                          ? AppColor.orangeColor
                          : task.priority_ == 'medium'
                              ? AppColor.darkBlueColor
                              : AppColor.lightBlueColor),
                ),
                const Spacer(),
                Text(
                  task.createdAt_.toString().substring(0, 10),
                  style: Styles.textStyle12.copyWith(color: AppColor.grayColor),
                )
              ],
            )
          ],
        )),
        GestureDetector(
          onTap: () {
            GoRouter.of(context).push(Routes.taskDetailsRoute, extra: task);
          },
          child: const Icon(
            Icons.more_vert_outlined,
            size: 30,
          ),
        ),
      ],
    );
  }
}
