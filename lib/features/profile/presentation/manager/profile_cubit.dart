import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/features/profile/domain/entity/profile_entity.dart';
import 'package:tasky/features/profile/domain/use_case/profile_use_case.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.profileUseCase) : super(ProfileInitial());

  static ProfileCubit getCubit(context) => BlocProvider.of(context);

  final ProfileUseCase profileUseCase;

  ProfileEntity? profileEntity;
  getProfile() async {
    emit(GetProfileLoadingState());
    var res = await profileUseCase.getProfile();
    res.fold((f){
      emit(GetProfileErrorState());
    }, (s){
      profileEntity = s;
      emit(GetProfileSuccessSate());
    });
  }
}
