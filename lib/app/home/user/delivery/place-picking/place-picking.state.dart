part of 'place-picking.cubit.dart';

@immutable
abstract class PlacePickingState extends Equatable {
  const PlacePickingState();
}
class PlacePickingInitial extends PlacePickingState {
  const PlacePickingInitial();

  @override
  List<Object> get props => [];
}
