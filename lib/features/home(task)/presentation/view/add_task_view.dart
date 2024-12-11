import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:tasky/constant.dart';
import 'package:tasky/core/utils/app_manager/app_reference.dart';
import 'package:tasky/core/utils/functions/first_letter_cap.dart';
import 'package:tasky/core/utils/functions/go_next.dart';
import 'package:tasky/core/widgets/custom_button.dart';
import 'package:tasky/core/widgets/custom_text_field.dart';
import 'package:tasky/features/home(task)/domain/entities/task_entity.dart';
import 'package:tasky/features/home(task)/presentation/manager/task_cubit.dart';

import '../../../../core/utils/app_manager/app_assets.dart';
import '../../../../core/utils/app_manager/app_color.dart';
import '../../../../core/utils/app_manager/app_styles.dart';
import '../../../../core/utils/functions/picke_date.dart';

class AddTaskView extends StatefulWidget {
  const AddTaskView({super.key, this.editedTask});

  final TaskEntity? editedTask;

  @override
  State<AddTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {
  final taskTitleController = TextEditingController();

  final taskDescriptionController = TextEditingController();

  final taskDueDateController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.editedTask != null) {
      taskTitleController.text = widget.editedTask!.title_;
      taskDescriptionController.text = widget.editedTask!.desc_;
      TaskCubit.getCubit(context).taskImage = File(widget.editedTask!.image_);
      TaskCubit.getCubit(context).choosePriority(
          '${formatText(widget.editedTask!.priority_)} Priority');
      TaskCubit.getCubit(context)
          .chooseStatus(formatText(widget.editedTask!.status_));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskCubit, TaskState>(
      listener: (context, state) {
        if (state is AddTaskSuccessState) {
          TaskCubit.getCubit(context).getTasks(1);
          taskDueDateController.text = '';
          taskDescriptionController.text = '';
          taskTitleController.text = '';
          TaskCubit.getCubit(context).taskImage = null;
          TaskCubit.getCubit(context).imageEntity = null;
          showSnackBar(context: context, message: 'Task added successfully');
          GoRouter.of(context).pop('new tasks');
        }
        if (state is EditTaskSuccessState) {
          TaskCubit.getCubit(context).getTasks(1);
          showSnackBar(context: context, message: 'Task edited successfully');
          GoRouter.of(context).pop('new tasks');
          GoRouter.of(context).pop('new tasks');
        }
        if (state is AddTaskErrorState) {
          if (state.failure.errorMessage.contains('401')) {
            TaskCubit.getCubit(context)
                .refreshToken(AppReference.getData(key: refreshToken));
          }
          showSnackBar(
              context: context,
              message: 'Ops something went wrong, please try again');
        }
        if (state is EditTaskErrorState) {
          if (state.failure.errorMessage.contains('401')) {
            TaskCubit.getCubit(context)
                .refreshToken(AppReference.getData(key: refreshToken));
          }
          showSnackBar(
              context: context,
              message: 'Ops something went wrong, please try again');
        }
      },
      builder: (context, state) {
        var cubit = TaskCubit.getCubit(context);
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            backgroundColor: AppColor.whiteColor,
            title: Text(
              widget.editedTask != null ? 'Edit task' : 'Add new task',
              style: Styles.textStyle16,
            ),
            leading: GestureDetector(
                onTap: () {
                  GoRouter.of(context).pop('new tasks');
                },
                child: Image.asset(
                  AssetsData.arrowLeft,
                  width: 24,
                  height: 24,
                  color: AppColor.blackColor,
                )),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        cubit.pickImage();
                      },
                      child: DottedBorder(
                        padding: const EdgeInsets.all(15),
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(10),
                        color: AppColor.darkBlueColor,
                        dashPattern: const [3, 3],
                        strokeWidth: 1.5,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (cubit.taskImage == null)
                                Image.asset(
                                  AssetsData.imageIcon,
                                  width: 24,
                                  height: 24,
                                  color: AppColor.darkBlueColor,
                                ),
                              if (cubit.taskImage == null)
                                const SizedBox(
                                  width: 5,
                                ),
                              cubit.taskImage != null
                                  ? widget.editedTask != null
                                      ? Text(
                                          cubit.taskImage!.path.split('-').last,
                                          style: Styles.textStyle16.copyWith(
                                              color: AppColor.darkBlueColor),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        )
                                      : Text(
                                          cubit.taskImage!.path.split('/').last,
                                          style: Styles.textStyle16.copyWith(
                                              color: AppColor.darkBlueColor),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        )
                                  : Text(
                                      'Add Img',
                                      style: Styles.textStyle16.copyWith(
                                          color: AppColor.darkBlueColor),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                            ]),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Task title',
                      style: Styles.textStyle12
                          .copyWith(color: AppColor.grayColor),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    CustomTextField(
                      controller: taskTitleController,
                      hintText: 'Enter title here...',
                      inputType: TextInputType.text,
                      borderRadius: 10,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter task title';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Task Description',
                      style: Styles.textStyle12
                          .copyWith(color: AppColor.grayColor),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    CustomTextField(
                      controller: taskDescriptionController,
                      hintText: 'Enter description here...',
                      inputType: TextInputType.text,
                      borderRadius: 10,
                      maxLines: 5,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter task description';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    if (widget.editedTask != null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Status',
                            style: Styles.textStyle12
                                .copyWith(color: AppColor.grayColor),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
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
                                    ? formatText(widget.editedTask!.status_)
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
                        ],
                      ),
                    Text(
                      'Priority',
                      style: Styles.textStyle12
                          .copyWith(color: AppColor.grayColor),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
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
                                style: Styles.textStyle16.copyWith(
                                    color: AppColor.darkBlueColor,
                                    fontWeight: FontWeight.bold),
                                value: cubit.selectedPriority,
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
                    const SizedBox(
                      height: 15,
                    ),
                    if (widget.editedTask == null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Due date',
                            style: Styles.textStyle12
                                .copyWith(color: AppColor.grayColor),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          CustomTextField(
                            controller: taskDueDateController,
                            onTaped: () async {
                              FocusScope.of(context).requestFocus(FocusNode());
                              DateTime? date = await pickDate(context);
                              if (date != null) {
                                taskDueDateController.text =
                                    DateFormat('yyyy-MM-dd').format(date);
                              }
                            },
                            hintText: 'choose due date...',
                            inputType: TextInputType.datetime,
                            borderRadius: 10,
                            suffixIcon: Image.asset(
                              AssetsData.calendarIcon,
                              width: 24,
                              height: 24,
                              color: AppColor.darkBlueColor,
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                      isLoading: state is AddTaskLoadingState ||
                          state is EditTaskLoadingState,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          if (widget.editedTask == null) {
                            if (cubit.imageEntity != null) {
                              cubit.addTask(
                                taskTitleController.text.toString(),
                                taskDescriptionController.text.toString(),
                                taskDueDateController.text.toString(),
                                cubit.selectedPriority
                                    .split(' ')
                                    .first
                                    .toLowerCase(),
                              );
                            } else {
                              showSnackBar(
                                  context: context,
                                  message: 'Please choose task image');
                            }
                          } else {
                            String image = cubit.imageEntity != null
                                ? cubit.imageEntity!.image_
                                : widget.editedTask!.image_;
                            cubit.editTask(
                                widget.editedTask!.id_,
                                taskTitleController.text.toString(),
                                taskDescriptionController.text.toString(),
                                cubit.selectedPriority
                                    .split(' ')
                                    .first
                                    .toLowerCase(),
                                cubit.selectedStatus.toLowerCase(),
                                widget.editedTask!.user_,
                                image);
                          }
                        }
                      },
                      text:
                          widget.editedTask != null ? 'Edit task' : 'Add task',
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
