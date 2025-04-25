part of 'auth_bloc.dart';


abstract class AuthEvent{}

class AuthLoginEvent extends AuthEvent{
  final String ? email;
  final String ? password;
  AuthLoginEvent({this.email,this.password});
}

class AuthRegisterEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final String rePassword;
  final File? photo;

  AuthRegisterEvent({
    required this.name,
    required this.email,
    required this.password,
    required this.rePassword,
    this.photo,
  });
}