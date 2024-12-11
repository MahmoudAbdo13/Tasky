import 'package:flutter/material.dart';

import '../../../../../core/utils/app_manager/app_color.dart';
import '../../../../../core/utils/app_manager/app_styles.dart';

class ProfileField extends StatelessWidget {
  final String label;
  final String value;
  final Widget? trailing;

  const ProfileField({
    super.key,
    required this.label,
    required this.value,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColor.grayOpacityColor, // Light gray background for the container
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    label.toUpperCase(),
                    style: Styles.textStyle12.copyWith(color: AppColor.grayColor)
                ),
                const SizedBox(height: 4),
                Text(
                    value,
                    style: Styles.textStyle16.copyWith(color: AppColor.blackColor)
                ),
              ],
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
