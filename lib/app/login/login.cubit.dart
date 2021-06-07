import 'dart:developer';

import 'package:v_post/config/application.dart';
import 'package:v_post/model/user/order/order.dart';
import 'package:v_post/service/account/account.service.dart';
import 'package:v_post/utils/exception.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login.state.dart';

class LoginCubit extends Cubit<LoginState> {
  AccountService _accountService;

  LoginCubit(this._accountService) : super(LoginInitial());

  Future<bool> login(Map<String, dynamic> data) async {
    var params = {
      "phone": data["user_name"],
      "password": data["password"],
    };
    try {
      emit(Signing());
      Account result = await _accountService.login(params);
      Application.sharePreference..putInt("userId", result.id ?? 0);
      Application.sharePreference..putInt("type", result.type ?? 0);
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
