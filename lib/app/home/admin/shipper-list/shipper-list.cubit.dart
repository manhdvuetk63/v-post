import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:v_post/model/user/order/order.dart';
import 'package:v_post/service/account/account.service.dart';

part 'shipper-list.state.dart';

class ShipperListCubit extends Cubit<ShipperListState> {
  AccountService _accountService;
  Accounts? accounts;

  ShipperListCubit(this._accountService) : super(ShipperListInitial()){
    getAccountByType(1);
  }

  Future<Accounts?> getAccountByType(int type) async {
    emit(ShipperLoading());
    accounts = await _accountService.getAccountByType(type);
    emit(ShipperLoaded());
    return accounts;
  }
}
