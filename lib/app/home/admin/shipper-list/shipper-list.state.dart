part of 'shipper-list.cubit.dart';

@immutable
abstract class ShipperListState extends Equatable {
  const ShipperListState();
}

class ShipperListInitial extends ShipperListState {
  const ShipperListInitial();

  @override
  List<Object> get props => [];
}
class ShipperLoading extends ShipperListState {
  const ShipperLoading();

  @override
  List<Object> get props => [];
}
class ShipperLoaded extends ShipperListState {
  const ShipperLoaded();

  @override
  List<Object> get props => [];
}
class ShipperLoadFalse extends ShipperListState {
  const ShipperLoadFalse();

  @override
  List<Object> get props => [];
}
