import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tasky/core/utils/app_manager/app_color.dart';
import 'package:tasky/core/utils/app_manager/app_reference.dart';
import '../../../constant.dart';
import '../app_manager/app_routes.dart';
import '../app_manager/app_styles.dart';

void goNext(BuildContext context) {
  if(AppReference.getData(key: onBoarding)== null){
    GoRouter.of(context).pushReplacement(Routes.onboardingRoute);
  }else{
    if(AppReference.getData(key: userToken)!= null){
      GoRouter.of(context).pushReplacement(Routes.mainRoute);
    }else{
      GoRouter.of(context).pushReplacement(Routes.loginRoute);
    }
  }

}

void showSnackBar({required BuildContext context, required String message}) {
  ScaffoldMessenger.of(context).showSnackBar(
    snackBarAnimationStyle: AnimationStyle(curve: Curves.bounceOut),
      SnackBar(
        padding: const EdgeInsets.all(15),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15))),
        backgroundColor: AppColor.darkBlueColor,
    content: Center(child: Text(message,style: Styles.textStyle16.copyWith(color: AppColor.whiteColor),)),
    duration: const Duration(seconds: 2),
  ));
}