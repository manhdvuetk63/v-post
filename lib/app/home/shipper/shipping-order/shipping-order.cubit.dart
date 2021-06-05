import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:v_post/config/application.dart';
import 'package:v_post/model/user/order/order.dart';
import 'package:v_post/service/delivery/delivery.service.dart';

part 'shipping-order.state.dart';

class ShippingOrderCubit extends Cubit<ShippingOrderState> {
  DeliveryService _deliveryService;
  Orders? orders;

  ShippingOrderCubit(this._deliveryService) : super(ShippingOrderInitial()){
    getOrder(1);
  }

  Future<Orders?> getOrder(int status) async {
    emit(Loading());
    var params = {"status": status, "id": Application.sharePreference.getInt("userId")};
    orders = await _deliveryService.getOrderByShipperIdAndStatus(params);
    emit(Loaded());
    return orders;
  }
}
