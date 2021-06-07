import 'package:v_post/config/application.dart';

class AccountRepository {
  static Future<dynamic> login(Map<String,dynamic> params){
    return Application.api.post('/login',params);
  }
  static Future<dynamic> signUp(Map<String,dynamic> params){
    return Application.api.post('/register',params);
  }
  static Future<dynamic> getAccountById(int params){
    return Application.api.get('/profile/$params');
  }
  static Future<dynamic> getAccountByType(int type) {
    // 1- User 2- Shipper 3- Admin
    return Application.api.get('/accounts/$type');
  }

}
