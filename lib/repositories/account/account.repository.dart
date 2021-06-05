import 'package:v_post/config/application.dart';

class AccountRepository {

  static Future<dynamic> createOrder(Map<String, dynamic> params) {
    return Application.api.post('/orders/create', params);
  }

}
