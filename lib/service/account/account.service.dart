import 'package:v_post/model/user/order/order.dart';
import 'package:v_post/repositories/account/account.repository.dart';
import 'package:v_post/utils/exception.dart';

class AccountService {
  Future<Account> login(Map<String, dynamic> params) async {
    final response = await AccountRepository.login(params);
    return (response.statusCode == 200)
        ? Account.fromJson(response.data as Map<String, dynamic>)
        : throw NetworkException(message: Map<String, dynamic>.from("login false" as Map<String,dynamic>));
  }
  Future<Account> getAccountById(int params) async {
    final response = await AccountRepository.getAccountById(params);
    return (response.statusCode == 200)
        ? Account.fromJson(response.data as Map<String, dynamic>)
        : throw NetworkException(message: Map<String, dynamic>.from("login false" as Map<String,dynamic>));
  }
  Future<Accounts> getAccountByType(int type) async {
    final response = await AccountRepository.getAccountByType(type);
    return (response.statusCode == 200)
        ? Accounts.fromJson(response.data as Map<String, dynamic>)
        : throw NetworkException(message: Map<String, dynamic>.from("create false" as Map<String, dynamic>));
  }

}
