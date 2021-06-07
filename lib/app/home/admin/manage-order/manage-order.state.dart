part of 'manage-order.cubit.dart';

@immutable
abstract class ManageOrderState extends Equatable {
  const ManageOrderState();
}

class ManageOrderInitial extends ManageOrderState {
  const ManageOrderInitial();

  @override
  List<Object> get props => [];
}

class OrdersLoading extends ManageOrderState {
  const OrdersLoading();

  @override
  List<Object> get props => [];
}

class OrdersLoaded extends ManageOrderState {
  const OrdersLoaded();

  @override
  List<Object> get props => [];
}

class OrdersLoadFalse extends ManageOrderState {
  const OrdersLoadFalse();

  @override
  List<Object> get props => [];
}

class ShipperLoading extends ManageOrderState {
  const ShipperLoading();

  @override
  List<Object> get props => [];
}

class ShipperLoaded extends ManageOrderState {
  const ShipperLoaded();

  @override
  List<Object> get props => [];
}

class ShipperLoadFalse extends ManageOrderState {
  const ShipperLoadFalse();

  @override
  List<Object> get props => [];
}
class Forwarded extends ManageOrderState {
  const Forwarded();

  @override
  List<Object> get props => [];
}

class Forwarding extends ManageOrderState {
  const Forwarding();

  @override
  List<Object> get props => [];
}
class ForwardFalse extends ManageOrderState {
  const ForwardFalse();

  @override
  List<Object> get props => [];
}