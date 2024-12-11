import 'package:flutter/material.dart';
import '../../../core/utils/app_manager/app_color.dart';
import '../../core/utils/app_manager/app_assets.dart';
import '../../core/utils/functions/go_next.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    navigateToNext();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.darkBlueColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
              child: Image.asset(
            height: 50,
            AssetsData.splashImage,
          )),
        ],
      ),
    );
  }

  void navigateToNext() {
    Future.delayed(const Duration(seconds: 4), () {
      if (!mounted) return;
      goNext(context);
    });
  }
}
