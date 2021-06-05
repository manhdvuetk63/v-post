import 'package:v_post/config/application.dart';
import 'package:v_post/utils/exception.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login.state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<bool> login(Map<String, dynamic> data) async {
    // var params = {
    //   "userName": data["user_name"],
    //   "password": data["password"],
    // };
    try {
      emit(Signing());
      // LoginData result = await _authenticationService.login(params);
      Application.sharePreference..putInt("userId", 1);
      emit(Signed());
      return true;
    } on NetworkException catch (e) {
      var _message = e.message!["message"] != null ? "${e.message!["message"]}" : "";
      emit(LoginError(_message));
      emit(Signed());
      return false;
    }
  }
}
