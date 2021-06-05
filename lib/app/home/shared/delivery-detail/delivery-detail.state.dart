part of 'delivery-detail.cubit.dart';

@immutable
abstract class DeliveryDetailState extends Equatable {
  const DeliveryDetailState();
}

class DeliveryDetailInitial extends DeliveryDetailState {
  const DeliveryDetailInitial();

  @override
  List<Object> get props => [];
}
class OrderLoading extends DeliveryDetailState {
  const OrderLoading();

  @override
  List<Object> get props => [];
}
class OrderLoaded extends DeliveryDetailState {
  const OrderLoaded();

  @override
  List<Object> get props => [];
}
class OrderLoadFalse extends DeliveryDetailState {
  const OrderLoadFalse();

  @override
  List<Object> get props => [];
}
