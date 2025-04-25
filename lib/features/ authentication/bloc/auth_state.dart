part of 'auth_bloc.dart';


abstract class AuthState {}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthLoginState extends AuthState {
  late final LoginResponseModel data;

  AuthLoginState(data);
}

class AuthRegisterState extends AuthState {
  final RegisterResponseModel data;
  AuthRegisterState(this.data);
}

class AuthErrorState extends AuthState {
  final ResponseModel data;

  AuthErrorState(this.data);
}

