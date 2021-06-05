import 'package:v_post/config/application.dart';

class AccountRepository {

  static Future<dynamic> getAccountByType(int type) {
    // 1- User 2- Shipper 3- Admin
    return Application.api.get('/accounts/$type');
  }

}
