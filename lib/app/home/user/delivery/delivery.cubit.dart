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
  WeMapDirections directionAPI = WeMapDirections();
  int tripDistance = 0;

  DeliveryCubit(this._deliveryService) : super(DeliveryInitial()) {}

  Future<Order> confirmOrder(Map<String, dynamic> data) async {
    order = Order.fromJson({
      "item": data['package_name'],
      "value": int.parse(data['package_price'].toString()),
      "weight": double.parse(data['package_weight'].toString()),
      "description": data['package_description'],
      "status": 0,
      "senderName": data['sender_name'],
      "senderPhone": data['sender_phone'],
      "senderAddress": data['sender_address'],
      "receiverName": data['receiver_name'],
      "receiverPhone": data['receiver_phone'],
      "receiverAddress": data['receiver_address'],
      "orderedDate": DateTime.now().toString().substring(0, 10),
    });
    var json = await directionAPI.getResponseMultiRoute(0, [placeSender!.location!, placeReceiver!.location!]); //0 = car, 1 = bike, 2 = foot
    print(json);
    var dis = double.parse((directionAPI.getDistance(json) / 1000).toStringAsFixed(1));
    int feeShip;
    int feeItem;
    if (dis < 3) {
      feeShip = 20000;
    } else {
      feeShip = (dis * 10000).round();
    }
    if (order.value! < 500000) {
      feeItem = 0;
    } else {
      feeItem = 50000;
    }
    order.fee = "${feeItem + feeShip} VNĐ";
    order.distance = "$dis km";
    print(order.toJson());
    return order;
  }

  Future<Order> createOrder(Map<String, dynamic> data) async {
    var params = {
      "item": data['package_name'],
      "value": int.parse(data['package_price'].toString()),
      "weight": double.parse(data['package_weight'].toString()),
      "description": data['package_description'],
      "status": 0,
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
      "creatorUserId": Application.sharePreference.getInt("userId")
    };
    emit(Create());
    var response = await _deliveryService.createNewOrder(params);
    emit(Created());
    return response;
  }
}
