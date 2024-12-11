import 'package:flutter/material.dart';
import '../utils/app_manager/app_color.dart';
import '../utils/app_manager/app_styles.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,this.hintText,this.inputType,this.hintColor,this.suffixIcon,this.onTaped,this.isObscureText = false,required this.controller,this.validator, this.height, this.borderRadius, this.backgroundColor, this.suffixWidget, this.maxLines
  });
  final String? hintText;
  final Widget? suffixIcon;
  final void Function()? onTaped;
  final Widget? suffixWidget;
  final bool isObscureText;
  final double? height;
  final int? maxLines;
  final double? borderRadius;
  final Color? backgroundColor;
  final Color? hintColor;
  final TextInputType? inputType;
  final TextEditingController controller;
  final String? Function(String?)? validator;


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      onTap: onTaped,
      keyboardType: inputType,
      controller: controller,
      textAlignVertical: TextAlignVertical.top,
      obscureText: isObscureText,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        suffix: suffixWidget,
        filled: true,
        fillColor: backgroundColor ?? Colors.transparent,
        hintText: hintText,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16,vertical: 17),
        hintStyle: Styles.textStyle14.copyWith(color: hintColor ?? AppColor.grayColor),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.darkBlueColor),
          borderRadius: BorderRadius.circular(borderRadius ?? 16),
        ),
        border: OutlineInputBorder(
            borderSide:  BorderSide(color: AppColor.whiteColor),
            borderRadius: BorderRadius.circular(borderRadius ?? 16)),
        enabledBorder: OutlineInputBorder(
          borderSide:  BorderSide(color:AppColor.grayColor),
          borderRadius: BorderRadius.circular(borderRadius ?? 16),
        ),
      ),
      validator: validator,

    );
  }
}