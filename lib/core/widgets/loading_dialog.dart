import 'package:flutter/material.dart';
import 'package:tasky/core/utils/app_manager/app_color.dart';

void showProgressDialog(BuildContext context) {
  showDialog(
    barrierColor: AppColor.grayColor.withOpacity(0.6),
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Center(
          child: CircularProgressIndicator(
            color: AppColor.darkBlueColor,
          ),
        ),
      );
    },
  );
}
