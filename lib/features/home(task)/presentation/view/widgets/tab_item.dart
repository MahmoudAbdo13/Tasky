import 'package:flutter/material.dart';
import '../../../../../core/utils/app_manager/app_color.dart';
import '../../../../../core/utils/app_manager/app_styles.dart';

class TabItem extends StatelessWidget {
  const TabItem({
    super.key,
    required this.text, required this.current,
  });

  final String text;
  final String current;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: current==text?AppColor.darkBlueColor:AppColor.darkBlueOpacity),
      child: Text(
        text,
        style: Styles.textStyle16.copyWith(color: current==text?AppColor.whiteColor:AppColor.grayColor),
      ),
    );
  }
}
