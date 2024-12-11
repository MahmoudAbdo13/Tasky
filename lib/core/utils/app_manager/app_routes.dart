import 'package:go_router/go_router.dart';
import 'package:tasky/features/auth/presentation/view/login_view.dart';
import 'package:tasky/features/auth/presentation/view/sign_up_view.dart';
import 'package:tasky/features/home(task)/domain/entities/task_entity.dart';
import 'package:tasky/features/home(task)/presentation/view/add_task_view.dart';
import 'package:tasky/features/home(task)/presentation/view/qr_scanner_view.dart';
import 'package:tasky/features/home(task)/presentation/view/task_details_view.dart';
import 'package:tasky/features/profile/presentation/view/profile_view.dart';
import '../../../features/home(task)/presentation/view/home_view.dart';
import '../../../features/onboarding/onboarding_view.dart';
import '../../../features/splash/splash_view.dart';

class Routes {
  static const String splashRoute = "/";
  static const String onboardingRoute = "/onboarding";
  static const String loginRoute = "/login";
  static const String registerRoute = "/signUp";
  static const String profileRoute = "/profile";
  static const String taskDetailsRoute = "/tasksDetails";
  static const String newTaskRoute = "/newTask";
  static const String mainRoute = "/main";
  static const String scannerRoute = "/scanner";
}

abstract class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: <RouteBase>[
      GoRoute(
        path: Routes.splashRoute,
        builder: (context, state) {
          return const SplashView();
        },
      ),
      GoRoute(
        path: Routes.onboardingRoute,
        builder: (context, state) {
          return const OnboardingView();
        },
      ),
      GoRoute(
        path: Routes.loginRoute,
        builder: (context, state) {
          return LoginView();
        },
      ),
      GoRoute(
        path: Routes.registerRoute,
        builder: (context, state) {
          return SignUpView();
        },
      ),
      GoRoute(
        path: Routes.mainRoute,
        builder: (context, state) {
          return const HomeView();
        },
      ),
      GoRoute(
        path: Routes.profileRoute,
        builder: (context, state) {
          return const ProfileView();
        },
      ),
      GoRoute(
        path: Routes.newTaskRoute,
        builder: (context, state) {
          if (state.extra == null) {
            return const AddTaskView();
          } else {
            TaskEntity task = state.extra as TaskEntity;
            return AddTaskView(
              editedTask: task,
            );
          }
        },
      ),
      GoRoute(
        path: Routes.taskDetailsRoute,
        builder: (context, state) {
          TaskEntity task = state.extra as TaskEntity;
          return TaskDetailsView(
            taskEntity: task,
          );
        },
      ),
      GoRoute(
        path: Routes.scannerRoute,
        builder: (context, state) {
          return const QRScannerView();
        },
      ),
    ],
  );
}
