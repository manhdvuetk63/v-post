import 'package:v_post/model/user/order/order.dart';
import 'package:v_post/repositories/account/account.repository.dart';
import 'package:v_post/utils/exception.dart';

class AccountService {
  Future<Accounts> getAccountByType(int type) async {
    final response = await AccountRepository.getAccountByType(type);
    return (response.statusCode == 200)
        ? Accounts.fromJson(response.data as Map<String, dynamic>)
        : throw NetworkException(message: Map<String, dynamic>.from("create false" as Map<String, dynamic>));
  }
}
