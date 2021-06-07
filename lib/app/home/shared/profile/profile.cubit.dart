import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:v_post/app/home/shared/delivery-detail/delivery-detail.cubit.dart';
import 'package:v_post/config/application.dart';
import 'package:v_post/model/user/order/order.dart';
import 'package:v_post/service/account/account.service.dart';

part 'profile.state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  AccountService _accountService;
  Account? profile;

  ProfileCubit(this._accountService) : super(ProfileInitial()) {
    getProfile();
  }

  Future<void> getProfile() async {
    emit(Loading());
    profile = await _accountService.getAccountById(Application.sharePreference.getInt("userId") ?? 0);
    emit(Loaded());
  }
}
