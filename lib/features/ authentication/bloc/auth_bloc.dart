import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/model/response.model.dart';
import '../../../core/network/base_network_status.dart';
import '../model/login.response.model.dart';
import '../model/register.response.model.dart';
import '../repository/auth.repository.dart';


part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;

  AuthBloc(this.repository) : super(AuthInitialState()) {
    on<AuthLoginEvent>(_onAuthLoginEvent);
    on<AuthRegisterEvent>(_onAuthRegisterEvent);
  }

  void _onAuthLoginEvent(AuthLoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    ApiResult result = await repository.login(
      email: event.email,
      password: event.password,
    );
    if (result.status == ApiStatus.success) {
      emit(AuthLoginState(result.response));
    } else {
      emit(AuthErrorState(result.response));
    }
  }

  void _onAuthRegisterEvent(AuthRegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    ApiResult result = await repository.registerUser(
      name: event.name,
      email: event.email,
      password: event.password,
      rePassword: event.rePassword,
      photo: event.photo,
    );
    if (result.status == ApiStatus.success) {
      emit(AuthRegisterState(result.response));
    } else {
      emit(AuthErrorState(result.response));
    }
  }


}

