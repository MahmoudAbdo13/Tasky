import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:tasky/core/utils/app_manager/app_routes.dart';
import 'package:tasky/core/utils/functions/service_locator.dart';
import 'package:tasky/features/auth/domain/use_cases/login_use_case.dart';
import 'package:tasky/features/auth/domain/use_cases/register_use_case.dart';
import 'package:tasky/features/auth/presentation/manager/auth_cubit.dart';

import '../../../../core/utils/app_manager/app_assets.dart';
import '../../../../core/utils/app_manager/app_color.dart';
import '../../../../core/utils/app_manager/app_styles.dart';
import '../../../../core/utils/functions/go_next.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';

class SignUpView extends StatelessWidget {
  SignUpView({super.key});
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final yearsController = TextEditingController();
  final addressController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) =>
            AuthCubit(getIt.get<LoginUseCase>(), getIt.get<RegisterUseCase>()),
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if(state is RegisterSuccessState){
              GoRouter.of(context).pushReplacement(Routes.mainRoute);
            }
            if(state is RegisterErrorState){
              showSnackBar(context: context, message: 'Please verify the phone number, then try again.');
            }
          },
          builder: (context, state) {
            var cubit = AuthCubit.getCubit(context);
            return Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * .4,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(AssetsData.artImage),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        const Positioned(
                          bottom: 10,
                          left: 20,
                          child: Text(
                            'Sign Up',
                            style: Styles.textStyle24,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextField(
                              hintText: "Name",
                              controller: nameController,
                              borderRadius: 10,
                              inputType: TextInputType.name,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter your name';
                                }
                                return null;
                              },
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
                              onChanged: (phone) {
                                cubit.changeCountryCode(phone.countryCode);
                              },
                              validator: (value) {
                                if (!value!.isValidNumber()) {
                                  return 'Enter valid phone number';
                                }
                                return null;
                              },
                            ),
                            CustomTextField(
                              hintText: "Years of experience",
                              controller: yearsController,
                              borderRadius: 10,
                              inputType: TextInputType.number,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter your years of experience';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColor.grayColor
                                ),
                                borderRadius: BorderRadius.circular(12)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 3),
                                child: DropdownButton<String>(
                                  value: cubit.selectedLevel,
                                  isExpanded: true,
                                  underline: const SizedBox(),
                                  hint: const Text("Choose experience level",style: Styles.textStyle14,),
                                  items: cubit.level
                                      .map(
                                        (item) => DropdownMenuItem(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: Styles.textStyle14,
                                          ),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (value) {
                                    if(value != 'Choose experience level'){
                                      cubit.chooseLevel(value!);
                                    }
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomTextField(
                              hintText: "Address",
                              controller: addressController,
                              borderRadius: 10,
                              inputType: TextInputType.text,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter your address';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomTextField(
                              maxLines: 1,
                              hintText: "Password",
                              controller: passwordController,
                              borderRadius: 10,
                            isObscureText: cubit.obscure,
                              suffixIcon: GestureDetector(
                                onTap: (){
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
                              isLoading: state is RegisterLoading,
                              onPressed: () {
                                if(formKey.currentState!.validate()){
                                  cubit.signUp(
                                      cubit.countryCode+phoneController.text,
                                      passwordController.text,
                                      nameController.text,
                                      int.parse(yearsController.text.toString()),
                                      cubit.selectedLevel,
                                      addressController.text);
                                }
                              },
                              text: 'Sign Up',
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
                          'Already have any account? ',
                          style: Styles.textStyle14,
                        ),
                        InkWell(
                            onTap: () {
                              GoRouter.of(context)
                                  .pushReplacement(Routes.loginRoute);
                            },
                            child: Text(
                              'Sign In',
                              style: Styles.textStyle14
                                  .copyWith(color: AppColor.darkBlueColor),
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
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
