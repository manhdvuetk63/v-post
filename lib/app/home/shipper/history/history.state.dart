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
class Loading extends HistoryState {
  const Loading();

  @override
  List<Object> get props => [];
}
class Loaded extends HistoryState {
  const Loaded();

  @override
  List<Object> get props => [];
}
class LoadFalse extends HistoryState {
  const LoadFalse();

  @override
  List<Object> get props => [];
}
