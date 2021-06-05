part of 'shipping-order.cubit.dart';

@immutable
abstract class ShippingOrderState extends Equatable {
  const ShippingOrderState();
}

class ShippingOrderInitial extends ShippingOrderState {
  const ShippingOrderInitial();

  @override
  List<Object> get props => [];
}
class Loading extends ShippingOrderState {
  const Loading();

  @override
  List<Object> get props => [];
}
class Loaded extends ShippingOrderState {
  const Loaded();

  @override
  List<Object> get props => [];
}
class LoadFalse extends ShippingOrderState {
  const LoadFalse();

  @override
  List<Object> get props => [];
}
