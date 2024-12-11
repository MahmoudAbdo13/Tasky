import 'package:flutter/material.dart';

import '../app_manager/app_color.dart';

Future<DateTime?> pickDate(BuildContext context) async {
  DateTime? date = DateTime(2300);
  date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2300),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              brightness: Brightness.light,
              primary: AppColor.darkBlueColor,
              onPrimary: AppColor.whiteColor,
            ),
            dialogBackgroundColor:
            AppColor.whiteColor, // Background color of the date picker
          ),
          child: child!,
        );
      });
  return date;
}