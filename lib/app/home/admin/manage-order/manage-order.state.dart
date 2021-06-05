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
