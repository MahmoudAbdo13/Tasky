import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:tasky/core/utils/app_manager/app_color.dart';
import 'package:tasky/core/widgets/extension.dart';

Widget cachedImage(String? url, String placeHolder,
    {double? height,
    Color? color,
    double? width,
    BoxFit? fit,
    AlignmentGeometry? alignment,
    bool usePlaceholderIfUrlEmpty = true,
    double? radius}) {
  if (url!.validate().isEmpty) {
    return placeHolderWidget(
        placeHolder: placeHolder,
        height: height,
        width: width,
        fit: fit,
        alignment: alignment,
        radius: radius);
  } else if (url.validate().startsWith('http')) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.grayColor,
        borderRadius: radius == null
            ? BorderRadius.circular(0.0)
            : BorderRadius.circular(radius),
      ),
      child: ClipRRect(
        borderRadius: radius == null
            ? BorderRadius.circular(0.0)
            : BorderRadius.circular(radius),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: CachedNetworkImage(
          imageUrl: url,
          height: height,
          width: width,
          fit: BoxFit.cover,
          color: color,
          alignment: alignment as Alignment? ?? Alignment.center,
          progressIndicatorBuilder: (context, url, progress) {
            return placeHolderWidget(
                placeHolder: placeHolder,
                height: height,
                width: width,
                fit: fit,
                alignment: alignment,
                radius: radius);
          },
          errorWidget: (_, s, d) {
            return placeHolderWidget(
                placeHolder: placeHolder,
                height: height,
                width: width,
                fit: fit,
                alignment: alignment,
                radius: radius);
          },
        ),
      ),
    );
  } else {
    return Image.asset(placeHolder,
            height: height,
            width: width,
            fit: BoxFit.contain,
            alignment: alignment ?? Alignment.center)
        .cornerRadiusWithClipRRect(radius ?? 12);
  }
}

Widget placeHolderWidget(
    {double? height,
    String? placeHolder,
    double? width,
    BoxFit? fit,
    AlignmentGeometry? alignment,
    double? radius}) {
  return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: radius == null
              ? BorderRadius.circular(0.0)
              : BorderRadius.circular(radius),
          color: AppColor.darkBlueColor),
      child: Image.asset(
        placeHolder!,
        height: height,
        width: width,
        fit: BoxFit.contain,
        alignment: alignment ?? Alignment.center,
      ).cornerRadiusWithClipRRect(radius ?? 12));
}
