part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}
final class ObscureChanged extends AuthState {}
final class CountryCodeChanged extends AuthState {}
final class ExperienceLevelChanged extends AuthState {}
final class LoginLoading extends AuthState{}
final class LoginSuccessState extends AuthState{}
final class LoginErrorState extends AuthState{
}
final class RegisterLoading extends AuthState{}
final class RegisterSuccessState extends AuthState{}
final class RegisterErrorState extends AuthState{}



