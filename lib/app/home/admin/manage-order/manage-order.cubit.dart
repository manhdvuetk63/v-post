import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:v_post/model/user/order/order.dart';
import 'package:v_post/service/account/account.service.dart';
import 'package:v_post/service/delivery/delivery.service.dart';

part 'manage-order.state.dart';

class ManageOrderCubit extends Cubit<ManageOrderState> {
  Orders? orders;
  Accounts? listShipper;
  int? status;

  DeliveryService _deliveryService;
  AccountService _accountService;

  ManageOrderCubit(this._deliveryService, this._accountService) : super(ManageOrderInitial()) {
    status = 0;
    getScreen();
  }

  Future<void> getScreen() async {
    emit(OrdersLoading());
    await Future.wait([getListShipper(), getListOrderByStatus()]);
    emit(OrdersLoaded());
  }

  Future<Orders?> getListOrderByStatus() async {
    orders = await _deliveryService.getOrderByStatus(status ?? 0);
    return orders;
  }

  Future<Accounts?> getListShipper() async {
    listShipper = await _accountService.getAccountByType(2);
    return listShipper;
  }

  Future<bool> forwardOrder(dynamic shipperId, orderId) async {
    emit(Forwarding());
    var params = {"orderId": int.parse(orderId.toString()), "shipperId": int.parse(shipperId.toString())};
    var op = await _deliveryService.forwardOrder(params);
    if (op) {
      emit(Forwarded());
    } else {
      emit(ForwardFalse());
    }
    return op;
  }
}
