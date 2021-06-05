import 'package:v_post/config/application.dart';
import 'package:v_post/model/user/order/order.dart';
import 'package:v_post/repositories/login.repository.dart';
import 'package:v_post/utils/exception.dart';

class LoginService {
  Future<Account> login(Map<String, dynamic> params) async {
    final response = await LoginRepository.login(params);
    return (response.statusCode == 200) 
        ? Account.fromJson(response.data as Map<String, dynamic>) 
        : throw NetworkException(message: Map<String, dynamic>.from("login false" as Map<String,dynamic>));
  }

  static Future<dynamic> signUp(Map<String, dynamic> params) {
    return Application.api.post('/register', params);
  }
}
