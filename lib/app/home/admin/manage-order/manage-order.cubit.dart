import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:v_post/model/user/order/order.dart';
import 'package:v_post/service/delivery/delivery.service.dart';

part 'manage-order.state.dart';

class ManageOrderCubit extends Cubit<ManageOrderState> {
  Orders? orders;
  int? status;

  DeliveryService _deliveryService;

  ManageOrderCubit(this._deliveryService) : super(ManageOrderInitial()) {
    status = 0;
    getListOrderByStatus();
  }

  Future<Orders?> getListOrderByStatus() async {
    emit(OrdersLoading());
    orders = await _deliveryService.getOrderByStatus(status??0);
    emit(OrdersLoaded());
    return orders;
  }
}
