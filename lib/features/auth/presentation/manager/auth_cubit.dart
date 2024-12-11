import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_manager/app_color.dart';
import '../../domain/use_cases/login_use_case.dart';
import '../../domain/use_cases/register_use_case.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.loginUseCase, this.registerUseCase) : super(AuthInitial());
  static AuthCubit getCubit(context) => BlocProvider.of(context);
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final level = {'Choose experience level','fresh','junior','midLevel','senior'};
  String selectedLevel = 'Choose experience level';

  chooseLevel(String level){
    selectedLevel = level;
    emit(ExperienceLevelChanged());
  }

  bool obscure = true;
  Icon eyeIcon = Icon(
    Icons.visibility_off,
    color: AppColor.grayColor,
  );

  String countryCode ='';
  changeCountryCode(String code){
    countryCode = code;
    emit(CountryCodeChanged());
  }

  changeObscure() {
    obscure = !obscure;

    eyeIcon = obscure == true
        ? Icon(
      Icons.visibility_off,
      color: AppColor.grayColor,
    )
        : Icon(
      Icons.visibility,
      color: AppColor.grayColor,
    );
    emit(ObscureChanged());
  }

  login(String phone, String password) async {
    emit(LoginLoading());
    var res = await loginUseCase.login(phone, password);
    res.fold((failure) {
      emit(LoginErrorState());
    }, (success) {
      emit(LoginSuccessState());
    });
  }

  signUp(String phone, String password,String name,int experience,String level,String address) async {
    emit(RegisterLoading());
    var res = await registerUseCase.register(name,phone,experience,password,level,address);
    res.fold((failure) {
      emit(RegisterErrorState());
    }, (success) {
      emit(RegisterSuccessState());
    });
  }
}
