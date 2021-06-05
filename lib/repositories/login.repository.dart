import 'package:v_post/config/application.dart';

class LoginRepository {
  static Future<dynamic> login(Map<String,dynamic> params){
    return Application.api.post('/login',params);
  }
  static Future<dynamic> signUp(Map<String,dynamic> params){
    return Application.api.post('/register',params);
  }
}