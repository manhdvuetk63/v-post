import 'package:v_post/config/application.dart';

class DeliveryRepository {
  static Future<dynamic> createOrder(Map<String, dynamic> params) {
    return Application.api.post('/orders/create', params);
  }

  static Future<dynamic> getOrderByShipperIdAndStatus(Map<String, dynamic> params) {
    return Application.api.get('/orders/my-order', params);
  }

  static Future<dynamic> getOrderByUser(int params) {
    return Application.api.get('/orders/get-by-user-id/$params');
  }

  static Future<dynamic> getOrderDetail(int params) {
    return Application.api.get('/orders/detail/$params');
  }

  static Future<dynamic> getOrderByStatus(int params) {
    return Application.api.get('/orders/status/$params');
  }
  static Future<dynamic> forwardOrder(Map<String, dynamic> params) {
    return Application.api.post('/orders/forward',params);
  }
  static Future<dynamic> doneOrder(Map<String, dynamic> params) {
    return Application.api.post('/orders/done',params);
  }
}
