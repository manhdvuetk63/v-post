import 'dart:developer';

import 'package:v_post/model/user/order/order.dart';
import 'package:v_post/repositories/delivery/delivery.repository.dart';
import 'package:v_post/utils/exception.dart';

class DeliveryService {
  Future<Order> createNewOrder(Map<String, dynamic> params) async {
    final response = await DeliveryRepository.createOrder(params);
    return (response.statusCode == 200)
        ? Order.fromJson(response.data as Map<String, dynamic>)
        : throw NetworkException(message: Map<String, dynamic>.from("create false" as Map<String, dynamic>));
  }

  Future<Orders> getOrderByUser(int params) async {
    final response = await DeliveryRepository.getOrderByUser(params);
    return (response.statusCode == 200)
        ? Orders.fromJson(response.data as Map<String, dynamic>)
        : throw NetworkException(message: Map<String, dynamic>.from("get false" as Map<String, dynamic>));
  }

  Future<Orders> getOrderByShipperIdAndStatus(Map<String, dynamic> params) async {
    final response = await DeliveryRepository.getOrderByShipperIdAndStatus(params);
    return (response.statusCode == 200)
        ? Orders.fromJson(response.data as Map<String, dynamic>)
        : throw NetworkException(message: Map<String, dynamic>.from("get false" as Map<String, dynamic>));
  }

  Future<Order> getOrderDetail(int params) async {
    final response = await DeliveryRepository.getOrderDetail(params);
    return (response.statusCode == 200)
        ? Order.fromJson(response.data as Map<String, dynamic>)
        : throw NetworkException(message: Map<String, dynamic>.from("get false" as Map<String, dynamic>));
  }

  Future<Orders> getOrderByStatus(int params) async {
    final response = await DeliveryRepository.getOrderByStatus(params);
    return (response.statusCode == 200)
        ? Orders.fromJson(response.data as Map<String, dynamic>)
        : throw NetworkException(message: Map<String, dynamic>.from("get false" as Map<String, dynamic>));
  }

  Future<bool> forwardOrder(Map<String, dynamic> params) async {
    final response = await DeliveryRepository.forwardOrder(params);
    return (response.statusCode == 200);
  }
  Future<bool> doneOrder(Map<String, dynamic> params) async {
    final response = await DeliveryRepository.doneOrder(params);
    return (response.statusCode == 200);
  }
}
