import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:tasky/features/home(task)/presentation/manager/task_cubit.dart';
import 'package:tasky/features/home(task)/presentation/view/widgets/qr_scanner_shape.dart';

import '../../../../core/utils/app_manager/app_assets.dart';
import '../../../../core/utils/app_manager/app_color.dart';
import '../../../../core/utils/app_manager/app_routes.dart';
import '../../../../core/utils/app_manager/app_styles.dart';
import '../../../../core/utils/functions/go_next.dart';
import '../../../../core/widgets/loading_dialog.dart';

class QRScannerView extends StatefulWidget {
  const QRScannerView({super.key});

  @override
  State<StatefulWidget> createState() => _QRScannerViewState();
}

class _QRScannerViewState extends State<QRScannerView> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  String? value;
  bool flag = false;
  final controller = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskCubit, TaskState>(
      listener: (context, state) {
        if (state is GetOneTaskSuccessState) {
          Navigator.pop(context);
          GoRouter.of(context).push(Routes.taskDetailsRoute, extra: state.task);
        }
        if (state is GetOneTaskErrorState) {
          Navigator.pop(context);
          showSnackBar(context: context, message: 'Task not found please try again');
          flag = false;
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            backgroundColor: AppColor.whiteColor,
            title: const Text(
              'QR Scanner',
              style: Styles.textStyle16,
            ),
            leading: GestureDetector(
              onTap: () {
                GoRouter.of(context).pop('scanner');
              },
              child: Image.asset(
                AssetsData.arrowLeft,
                width: 24,
                height: 24,
                color: AppColor.blackColor,
              ),
            ),
          ),
          body: Center(
            child: MobileScanner(
              key: qrKey,
              overlayBuilder: (context, constraints) {
                return Container(
                  decoration: ShapeDecoration(
                    shape: QrScannerOverlayShape(
                      borderColor: AppColor.orangeColor,
                      borderRadius: 10,
                      borderLength: 30,
                      borderWidth: 10,
                      cutOutSize: 300,
                    ),
                  ),
                );
              },
              onDetect: (barcodes) {
                  setState(() {
                    value = barcodes.barcodes.first.displayValue;
                  });
                  if (value != null&& flag == false) {
                    flag = true;
                    showProgressDialog(context);
                    TaskCubit.getCubit(context).getOneTask(value!);
                  }
              },
              controller: controller,
            ),
          ),
        );
      },
    );
  }
}
