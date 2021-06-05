import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable(includeIfNull: true, explicitToJson: true)
class Orders {
  List<Order>? orders;

  Orders({this.orders});

  factory Orders.fromJson(Map<String, dynamic> json) => _$OrdersFromJson(json);

  Map<String, dynamic> toJson() => _$OrdersToJson(this);
}

@JsonSerializable(includeIfNull: true, explicitToJson: true)
class Order {
  int? id;
  String? item;
  int? value;
  double? weight;
  String? description;
  int? status;
  String? senderName;
  String? senderPhone;
  String? senderAddress;
  String? receiverName;
  String? receiverPhone;
  String? receiverAddress;
  DateTime? orderedDate;
  DateTime? sentDate;
  DateTime? receivedDate;
  DateTime? sentDateReal;
  DateTime? receivedDateReal;
  Account? account;
  Account? user;
  String? orderNo;
  String? fee;
  String? distance;
  int? creatorUserId;

  Order(
      {this.id,
      this.item,
      this.value,
      this.weight,
      this.description,
      this.status,
      this.senderName,
      this.senderPhone,
      this.senderAddress,
      this.receiverName,
      this.receiverPhone,
      this.receiverAddress,
      this.orderedDate,
      this.sentDate,
      this.receivedDate,
      this.account,
      this.orderNo,
      this.creatorUserId,
      this.fee,
      this.distance,
      this.receivedDateReal,
      this.user,
      this.sentDateReal});

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}

@JsonSerializable(includeIfNull: true, explicitToJson: true)
class Account {
  int? id;
  String? name;
  String? phone;
  String? password;
  String? address;
  int? type;

  Account({this.id, this.name, this.phone, this.password, this.address, this.type});

  factory Account.fromJson(Map<String, dynamic> json) => _$AccountFromJson(json);

  Map<String, dynamic> toJson() => _$AccountToJson(this);
}
