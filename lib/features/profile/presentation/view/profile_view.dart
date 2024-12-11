import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tasky/core/utils/app_manager/app_assets.dart';
import 'package:tasky/core/utils/app_manager/app_color.dart';
import 'package:tasky/core/utils/app_manager/app_styles.dart';
import 'package:tasky/core/utils/functions/go_next.dart';
import 'package:tasky/features/profile/presentation/view/widgets/profile_field.dart';

import '../../../../core/utils/functions/service_locator.dart';
import '../../domain/use_case/profile_use_case.dart';
import '../manager/profile_cubit.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(getIt.get<ProfileUseCase>())..getProfile(),  
      child: BlocConsumer<ProfileCubit, ProfileState>(
  listener: (context, state) {

  },
  builder: (context, state) {
    var cubit = ProfileCubit.getCubit(context);
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: AppColor.whiteColor,
        title: const Text('Profile',style: Styles.textStyle16,),
        leading: GestureDetector(
            onTap: (){
              GoRouter.of(context).pop();
            },
            child: Image.asset(AssetsData.arrowLeft,width: 24,height: 24,color: AppColor.blackColor,)),
      ),
      body: state is GetProfileLoadingState? const Center(child: CircularProgressIndicator()):Container(
        color: Colors.white, // Screen background color
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileField(label: 'Name', value: cubit.profileEntity!.displayName_),
              const SizedBox(height: 10),
              ProfileField(
                label: 'Phone',
                value: cubit.profileEntity!.username_,
                trailing: GestureDetector(
                  onTap: () async {
                    await Clipboard.setData(ClipboardData(text: cubit.profileEntity!.username_)).then((v){
                      if (!context.mounted) return;
                      showSnackBar(context: context, message: 'Phone number copied');
                    });
                  },
                    child: Image.asset(AssetsData.copyIcon,width: 24,height: 24,color: AppColor.darkBlueColor,)),
                ),
              const SizedBox(height: 10),
              ProfileField(label: 'Level', value: cubit.profileEntity!.level_),
              const SizedBox(height: 10),
              ProfileField(label: 'Years of Experience', value: cubit.profileEntity!.experienceYears_.toString()),
              const SizedBox(height: 10),
              ProfileField(label: 'Location', value: cubit.profileEntity!.address_),
            ],
          ),
        ),
      ),
    );
  },
),
);
  }
}


