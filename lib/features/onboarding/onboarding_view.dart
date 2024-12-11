import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tasky/constant.dart';
import 'package:tasky/core/utils/app_manager/app_assets.dart';
import 'package:tasky/core/utils/app_manager/app_color.dart';
import 'package:tasky/core/utils/app_manager/app_reference.dart';
import 'package:tasky/core/utils/app_manager/app_styles.dart';
import 'package:tasky/core/widgets/custom_button.dart';

import '../../core/utils/app_manager/app_routes.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height*.6,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AssetsData.artImage),
                  fit: BoxFit.fill,
                ),
              ),
            ),
           const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                'Task Management &\nTo-Do List',
                style: Styles.textStyle24,
                textAlign: TextAlign.center,
              ),
            ),
            Text(
              "This productive tool is designed to help\nyou better manage your task\nproject-wise conveniently!",
              style: Styles.textStyle14.copyWith(color: AppColor.grayColor),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: CustomButton(
                onPressed: (){
                  AppReference.setData(key: onBoarding, data: true);
                  GoRouter.of(context).pushReplacement(Routes.loginRoute);
                },text: "Let’s Start",isStart: true,),
            ),

          ],
        ),
      ),
    );
  }
}
