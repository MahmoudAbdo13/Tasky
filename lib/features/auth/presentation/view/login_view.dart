import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:tasky/core/utils/app_manager/app_routes.dart';
import 'package:tasky/core/utils/app_manager/app_styles.dart';
import 'package:tasky/core/utils/functions/go_next.dart';
import 'package:tasky/core/utils/functions/service_locator.dart';
import 'package:tasky/core/widgets/custom_button.dart';
import 'package:tasky/core/widgets/custom_text_field.dart';
import 'package:tasky/features/auth/domain/use_cases/login_use_case.dart';
import 'package:tasky/features/auth/domain/use_cases/register_use_case.dart';
import 'package:tasky/features/auth/presentation/manager/auth_cubit.dart';

import '../../../../core/utils/app_manager/app_assets.dart';
import '../../../../core/utils/app_manager/app_color.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) =>
            AuthCubit(getIt.get<LoginUseCase>(), getIt.get<RegisterUseCase>()),
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is LoginSuccessState) {
              GoRouter.of(context).pushReplacement(Routes.mainRoute);
            }
            if(state is LoginErrorState){
              showSnackBar(context: context, message: 'Please verify the phone number and password, then try again.');

            }
          },
          builder: (context, state) {
            var cubit = AuthCubit.getCubit(context);
            return Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * .45,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(AssetsData.artImage),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Login',
                              style: Styles.textStyle24,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            IntlPhoneField(
                              controller: phoneController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.transparent,
                                hintText: "Phone Number",
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 17),
                                hintStyle: Styles.textStyle14
                                    .copyWith(color: AppColor.grayColor),
                                errorBorder:  OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: AppColor.redColor),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColor.darkBlueColor),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: AppColor.whiteColor),
                                    borderRadius: BorderRadius.circular(10)),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColor.grayColor),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              initialCountryCode: 'EG',
                              validator: (value) {
                                if (value!.isValidNumber()) {
                                  return 'Enter valid phone number';
                                }else {
                                  return null;
                                }
                              },
                              onChanged: (phone) {
                                cubit.changeCountryCode(phone.countryCode);
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomTextField(
                              maxLines: 1,
                              isObscureText: cubit.obscure,
                              hintText: "Password",
                              controller: passwordController,
                              borderRadius: 10,
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  cubit.changeObscure();
                                },
                                child: cubit.eyeIcon,
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter your password';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            CustomButton(
                              isLoading: state is LoginLoading,
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  cubit.login(cubit.countryCode+phoneController.text,
                                      passwordController.text);
                                }
                              },
                              text: 'Sign In',
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Don\'t have an account? ',
                          style: Styles.textStyle14,
                        ),
                        InkWell(
                            onTap: () {
                              GoRouter.of(context)
                                  .pushReplacement(Routes.registerRoute);
                            },
                            child: Text(
                              'Sign Up here',
                              style: Styles.textStyle14
                                  .copyWith(color: AppColor.darkBlueColor),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
