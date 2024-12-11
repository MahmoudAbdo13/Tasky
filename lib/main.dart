import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/utils/app_manager/app_color.dart';
import 'package:tasky/core/utils/app_manager/app_routes.dart';

import 'core/utils/app_manager/app_reference.dart';
import 'core/utils/functions/service_locator.dart';
import 'core/widgets/bloc_observer.dart';
import 'features/home(task)/domain/use_cases/home_use_case.dart';
import 'features/home(task)/presentation/manager/task_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppReference.init();
  setupServices();
  Bloc.observer = TaskyBlocObserver();
  runApp(const TaskyApp());
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.dark,
  ));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

class TaskyApp extends StatelessWidget {
  const TaskyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TaskCubit(getIt.get<HomeUseCase>()),
        ),
      ],
      child: MaterialApp.router(
        title: 'Tasky',
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
        theme: ThemeData(
          scaffoldBackgroundColor: AppColor.whiteColor,
          colorScheme: ColorScheme.fromSeed(
              seedColor: AppColor.darkBlueColor,

          ),
          useMaterial3: true,
        ),
      ),
    );
  }
}
