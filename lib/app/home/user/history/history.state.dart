part of 'history.cubit.dart';

@immutable
abstract class HistoryState extends Equatable {
  const HistoryState();
}

class HistoryInitial extends HistoryState {
  const HistoryInitial();

  @override
  List<Object> get props => [];
}
class OrdersLoading extends HistoryState {
  const OrdersLoading();

  @override
  List<Object> get props => [];
}
class OrdersLoaded extends HistoryState {
  const OrdersLoaded();

  @override
  List<Object> get props => [];
}
class OrdersLoadFalse extends HistoryState {
  const OrdersLoadFalse();

  @override
  List<Object> get props => [];
}
