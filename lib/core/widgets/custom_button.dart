import 'package:flutter/material.dart';
import 'package:tasky/core/utils/app_manager/app_assets.dart';

import '../utils/app_manager/app_color.dart';
import '../utils/app_manager/app_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key, this.text, required this.onPressed, this.isLoading = false,this.isStart = false});
  final String? text;
  final void Function()? onPressed;
  final bool isLoading;
  final bool isStart;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width*.93,
      child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
              backgroundColor: AppColor.darkBlueColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12))),
          child: !isLoading
              ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(text ?? '',
                    style: Styles.textStyle16
                    .copyWith(color: AppColor.whiteColor),
                  ),
                  if(isStart)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(AssetsData.arrowRight,width: 15,height: 15,),
                  ),
                ],
              ) : Center(
              child: SizedBox(
                width: 25,
                height: 25,
                child: CircularProgressIndicator(
                  color: AppColor.whiteColor,
                ),
              ))),
    );
  }
}