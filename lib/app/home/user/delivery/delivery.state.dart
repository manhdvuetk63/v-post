part of 'delivery.cubit.dart';

@immutable
abstract class DeliveryState extends Equatable {
  const DeliveryState();
}

class DeliveryInitial extends DeliveryState {
  const DeliveryInitial();

  @override
  List<Object> get props => [];
}
class Create extends DeliveryState {
  const Create();

  @override
  List<Object> get props => [];
}
class Created extends DeliveryState {
  const Created();

  @override
  List<Object> get props => [];
}
class CreateFalse extends DeliveryState {
  const CreateFalse();

  @override
  List<Object> get props => [];
}
