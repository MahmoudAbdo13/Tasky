import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tasky/constant.dart';
import 'package:tasky/core/utils/app_manager/app_assets.dart';
import 'package:tasky/core/utils/app_manager/app_color.dart';
import 'package:tasky/core/utils/app_manager/app_reference.dart';
import 'package:tasky/core/utils/app_manager/app_routes.dart';
import 'package:tasky/core/utils/app_manager/app_styles.dart';
import 'package:tasky/features/home(task)/presentation/view/widgets/all_tasks_view_tab.dart';
import 'package:tasky/features/home(task)/presentation/view/widgets/finished_tasks_view_tab.dart';
import 'package:tasky/features/home(task)/presentation/view/widgets/inprogress_tasks_view_tab.dart';
import 'package:tasky/features/home(task)/presentation/view/widgets/tab_item.dart';
import 'package:tasky/features/home(task)/presentation/view/widgets/waiting_tasks_view_tab.dart';
import '../../../../core/utils/functions/go_next.dart';
import '../../../../core/widgets/loading_dialog.dart';
import '../manager/task_cubit.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {


  @override
  void initState() {
    TaskCubit.getCubit(context).getTasks(1);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskCubit, TaskState>(
        listener: (context, state) {
          if(state is LogoutSuccessState){
            AppReference.removeData(key: userToken);
            AppReference.removeData(key: userID);
            AppReference.removeData(key: refreshToken);
            GoRouter.of(context).pushReplacement(Routes.loginRoute);
          }
          if(state is LogoutErrorState){
            if(state.failure.errorMessage == '401'){
              TaskCubit.getCubit(context).refreshToken(AppReference.getData(key: refreshToken));
              TaskCubit.getCubit(context).logout(AppReference.getData(key: userToken));
            }
          }
          if(state is GetTasksErrorState){
            if (state.failure.errorMessage.contains('401')) {
              TaskCubit.getCubit(context)
                  .refreshToken(AppReference.getData(key: refreshToken));
            }
            showSnackBar(
                context: context,
                message: 'Ops something went wrong, please wait');
            TaskCubit.getCubit(context).getTasks(1);
          }
        },
        builder: (context, state) {
          var cubit = TaskCubit.getCubit(context);
          return Scaffold(
            appBar: AppBar(
    backgroundColor: AppColor.whiteColor,
    title: Image.asset(
      AssetsData.splashImage,
      color: AppColor.darkBlueColor,
      width: 80,
    ),
    actions: [
      GestureDetector(
          onTap: () {
            GoRouter.of(context).push(Routes.profileRoute);
          },
          child: const Icon(
            Icons.account_circle_outlined,
            size: 28,
          )),
      const SizedBox(
        width: 15,
      ),
      GestureDetector(
          onTap: () {
            showProgressDialog(context);
            cubit.logout(AppReference.getData(key: userToken));
          },
          child: Icon(
            Icons.logout,
            size: 28,
            color: AppColor.darkBlueColor,
          )),
      const SizedBox(
        width: 15,
      ),
    ],
            ),
            floatingActionButton:
      Column(mainAxisAlignment: MainAxisAlignment.end, children: [
    FloatingActionButton(
      heroTag: 'fab1',
      shape: const CircleBorder(),
      backgroundColor: AppColor.darkBlueOpacity,
      mini: true,
      onPressed: () {
        Object? refresh = GoRouter.of(context).push(Routes.scannerRoute);
        if (refresh == 'scanner') {
          cubit.getTasks(1);
        }
      },
      child: Icon(
        Icons.qr_code_rounded,
        color: AppColor.darkBlueColor,
      ),
    ),
    const SizedBox(
      height: 10,
    ),
    FloatingActionButton(
      backgroundColor: AppColor.darkBlueColor,
      shape: const CircleBorder(),
      onPressed: () {
        GoRouter.of(context).push(Routes.newTaskRoute);
      },
      heroTag: "fab2",
      child: Icon(
        Icons.add,
        size: 28,
        color: AppColor.whiteColor,
      ),
    ),
    const SizedBox(
      height: 20,
    ),
            ]),
            body: Padding(
    padding:
        const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'My Tasks',
          style:
              Styles.textStyle16.copyWith(color: AppColor.grayColor),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                cubit.changeTap('All');
              },
              child: TabItem(
                text: 'All',
                current: cubit.currentTap,
              ),
            ),
            GestureDetector(
              onTap: () {
                cubit.changeTap('In Progress');
              },
              child: TabItem(
                text: 'In Progress',
                current: cubit.currentTap,
              ),
            ),
            GestureDetector(
              onTap: () {
                cubit.changeTap('Waiting');
              },
              child: TabItem(
                text: 'Waiting',
                current: cubit.currentTap,
              ),
            ),
            GestureDetector(
                onTap: () {
                  cubit.changeTap('Finished');
                },
                child: TabItem(
                  text: 'Finished',
                  current: cubit.currentTap,
                )),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        if (cubit.currentTap == 'All') const AllTasksViewTab(),
        if (cubit.currentTap == 'In Progress') const InProgressTasksViewTab(),
        if (cubit.currentTap == 'Waiting') const WaitingTasksViewTab(),
        if (cubit.currentTap == 'Finished') const FinishedTasksViewTab(),
      ],
    ),
            ),
          );
        },
    );
  }
}
