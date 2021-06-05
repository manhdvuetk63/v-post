// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Orders _$OrdersFromJson(Map<String, dynamic> json) {
  return Orders(
    orders: (json['orders'] as List<dynamic>?)
        ?.map((e) => Order.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$OrdersToJson(Orders instance) => <String, dynamic>{
      'orders': instance.orders?.map((e) => e.toJson()).toList(),
    };

Accounts _$AccountsFromJson(Map<String, dynamic> json) {
  return Accounts(
    accounts: (json['accounts'] as List<dynamic>?)
        ?.map((e) => Account.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$AccountsToJson(Accounts instance) => <String, dynamic>{
      'accounts': instance.accounts?.map((e) => e.toJson()).toList(),
    };

Order _$OrderFromJson(Map<String, dynamic> json) {
  return Order(
    id: json['id'] as int?,
    item: json['item'] as String?,
    value: json['value'] as int?,
    weight: (json['weight'] as num?)?.toDouble(),
    description: json['description'] as String?,
    status: json['status'] as int?,
    senderName: json['senderName'] as String?,
    senderPhone: json['senderPhone'] as String?,
    senderAddress: json['senderAddress'] as String?,
    receiverName: json['receiverName'] as String?,
    receiverPhone: json['receiverPhone'] as String?,
    receiverAddress: json['receiverAddress'] as String?,
    orderedDate: json['orderedDate'] == null
        ? null
        : DateTime.parse(json['orderedDate'] as String),
    sentDate: json['sentDate'] == null
        ? null
        : DateTime.parse(json['sentDate'] as String),
    receivedDate: json['receivedDate'] == null
        ? null
        : DateTime.parse(json['receivedDate'] as String),
    account: json['account'] == null
        ? null
        : Account.fromJson(json['account'] as Map<String, dynamic>),
    orderNo: json['orderNo'] as String?,
    creatorUserId: json['creatorUserId'] as int?,
    fee: json['fee'] as String?,
    distance: json['distance'] as String?,
    receivedDateReal: json['receivedDateReal'] == null
        ? null
        : DateTime.parse(json['receivedDateReal'] as String),
    user: json['user'] == null
        ? null
        : Account.fromJson(json['user'] as Map<String, dynamic>),
    sentDateReal: json['sentDateReal'] == null
        ? null
        : DateTime.parse(json['sentDateReal'] as String),
  );
}

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'id': instance.id,
      'item': instance.item,
      'value': instance.value,
      'weight': instance.weight,
      'description': instance.description,
      'status': instance.status,
      'senderName': instance.senderName,
      'senderPhone': instance.senderPhone,
      'senderAddress': instance.senderAddress,
      'receiverName': instance.receiverName,
      'receiverPhone': instance.receiverPhone,
      'receiverAddress': instance.receiverAddress,
      'orderedDate': instance.orderedDate?.toIso8601String(),
      'sentDate': instance.sentDate?.toIso8601String(),
      'receivedDate': instance.receivedDate?.toIso8601String(),
      'sentDateReal': instance.sentDateReal?.toIso8601String(),
      'receivedDateReal': instance.receivedDateReal?.toIso8601String(),
      'account': instance.account?.toJson(),
      'user': instance.user?.toJson(),
      'orderNo': instance.orderNo,
      'fee': instance.fee,
      'distance': instance.distance,
      'creatorUserId': instance.creatorUserId,
    };

Account _$AccountFromJson(Map<String, dynamic> json) {
  return Account(
    id: json['id'] as int?,
    name: json['name'] as String?,
    phone: json['phone'] as String?,
    password: json['password'] as String?,
    address: json['address'] as String?,
    type: json['type'] as int?,
    email: json['email'] as String?,
    rate: (json['rate'] as num?)?.toDouble(),
  );
}

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'password': instance.password,
      'address': instance.address,
      'email': instance.email,
      'rate': instance.rate,
      'type': instance.type,
    };
