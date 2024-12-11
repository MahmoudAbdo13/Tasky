part of 'profile_cubit.dart';

abstract class ProfileState {}

final class ProfileInitial extends ProfileState {}
final class GetProfileLoadingState extends ProfileState {}
final class GetProfileErrorState extends ProfileState {}
final class GetProfileSuccessSate extends ProfileState {}

