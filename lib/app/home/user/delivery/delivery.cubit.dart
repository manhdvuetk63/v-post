import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:v_post/config/application.dart';
import 'package:v_post/model/user/order/order.dart';
import 'package:v_post/service/delivery/delivery.service.dart';
import 'package:wemapgl/wemapgl.dart';

part 'delivery.state.dart';

class DeliveryCubit extends Cubit<DeliveryState> {
  final DeliveryService _deliveryService;
  Order order = Order();
  WeMapPlace? placeSender;
  WeMapPlace? placeReceiver;

  DeliveryCubit(this._deliveryService) : super(DeliveryInitial()) {}

  Future<Order> confirmOrder(Map<String, dynamic> data) async {
    order = Order.fromJson({
      "item": data['package_name'],
      "value": int.parse(data['package_price'].toString()),
      "weight": double.parse(data['package_weight'].toString()),
      "description": data['package_description'],
      "status": false,
      "senderName": data['sender_name'],
      "senderPhone": data['sender_phone'],
      "senderAddress": data['sender_address'],
      "receiverName": data['receiver_name'],
      "receiverPhone": data['receiver_phone'],
      "receiverAddress": data['receiver_address'],
      "orderedDate": DateTime.now().toString(),
    });
    print(order.toJson());
    return order;
  }

  Future<Order> createOrder(Map<String, dynamic> data) async {
    var params = {
      "item": data['package_name'],
      "value": int.parse(data['package_price'].toString()),
      "weight": double.parse(data['package_weight'].toString()),
      "description": data['package_description'],
      "status": false,
      "senderName": data['sender_name'],
      "senderPhone": data['sender_phone'],
      "senderAddress": data['sender_address'],
      "receiverName": data['receiver_name'],
      "receiverPhone": data['receiver_phone'],
      "receiverAddress": data['receiver_address'],
      "orderedDate": DateTime.now().toString().substring(0, 10),
      "sentDate": DateTime.parse(data['picking_date'].toString()).toString().substring(0, 10),
      "receivedDate": DateTime.parse(data['receive_date'].toString()).toString().substring(0, 10),
      "distance": data['distance'],
      "fee": data['fee'],
      "creatorUserId": Application.sharePreference.getInt("UserId") ?? 1
    };
    emit(Create());
    var response = await _deliveryService.createNewOrder(params);
    emit(Created());
    return response;
  }
}
