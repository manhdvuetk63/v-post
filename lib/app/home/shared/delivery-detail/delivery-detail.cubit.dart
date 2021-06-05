import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:v_post/model/user/order/order.dart';
import 'package:v_post/service/delivery/delivery.service.dart';

part 'delivery-detail.state.dart';

class DeliveryDetailCubit extends Cubit<DeliveryDetailState> {
  Order? order;
  final DeliveryService _deliveryService;

  DeliveryDetailCubit(this._deliveryService) : super(DeliveryDetailInitial());

  Future<Order?> getOrderDetail(int params) async {
    emit(OrderLoading());
    order = await _deliveryService.getOrderDetail(params);
    emit(OrderLoaded());
    return order;
  }
}
