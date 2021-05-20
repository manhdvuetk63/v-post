part of 'home.cubit.dart';

@immutable
abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  const HomeInitial();

  @override
  List<Object> get props => [];
}

class HomeLoading extends HomeState {
  const HomeLoading();

  @override
  List<Object> get props => [];
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object> get props => [message];
}
class OffsetChanged extends HomeState {
  final double offset;

  OffsetChanged(this.offset);

  @override
  List<Object> get props => [offset];
}
