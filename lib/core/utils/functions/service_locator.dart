import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:tasky/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:tasky/features/home(task)/data/data_source/home_remote_data_source.dart';
import 'package:tasky/features/home(task)/data/repo/home_repo_impl.dart';
import 'package:tasky/features/home(task)/domain/use_cases/home_use_case.dart';
import 'package:tasky/features/profile/data/data_source/profile_remote_data_source.dart';
import 'package:tasky/features/profile/data/repo/profile_repo_impl.dart';
import 'package:tasky/features/profile/domain/use_case/profile_use_case.dart';

import '../../../features/auth/data/repo/auth_repo_impl.dart';
import '../../../features/auth/domain/use_cases/login_use_case.dart';
import '../../../features/auth/domain/use_cases/register_use_case.dart';
import '../api_services.dart';

final getIt = GetIt.instance;
void setupServices() {
  getIt.registerSingleton<ApiService>(ApiService(Dio()));
  getIt.registerSingleton<AuthRepoImpl>(
      AuthRepoImpl(AuthRemoteDataSourceImpl(getIt.get<ApiService>())));
  getIt.registerSingleton<LoginUseCase>(LoginUseCase(getIt.get<AuthRepoImpl>()));
  getIt.registerSingleton<RegisterUseCase>(RegisterUseCase(getIt.get<AuthRepoImpl>()));

  getIt.registerSingleton<HomeRepoImpl>(HomeRepoImpl(HomeRemoteDataSourceImpl(getIt.get<ApiService>())));
  getIt.registerSingleton<HomeUseCase>(HomeUseCase(getIt.get<HomeRepoImpl>()));

  getIt.registerSingleton<ProfileRepoImpl>(ProfileRepoImpl(ProfileRemoteDataSourceImpl(getIt.get<ApiService>())));
  getIt.registerSingleton<ProfileUseCase>(ProfileUseCase(getIt.get<ProfileRepoImpl>()));
}