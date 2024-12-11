import 'package:flutter/material.dart';
import 'package:tasky/core/utils/app_manager/app_assets.dart';
import 'package:tasky/core/utils/app_manager/app_color.dart';
import 'package:tasky/core/utils/app_manager/app_styles.dart';

class EmptyListComponent extends StatefulWidget {
  const EmptyListComponent({super.key});


  @override
  State<EmptyListComponent> createState() => _EmptyListComponentState();
}

class _EmptyListComponentState extends State<EmptyListComponent> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              AssetsData.noData,
              width: 100,
              height: 100,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'No tasks found, Please check back later',
                style: Styles.textStyle16.copyWith(color: AppColor.grayColor),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}