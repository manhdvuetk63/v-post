part of 'home.cubit.dart';

@immutable
abstract class UserHomeState extends Equatable {
  const UserHomeState();
}

class UserHomeInitial extends UserHomeState {
  const UserHomeInitial();

  @override
  List<Object> get props => [];
}

class UserHomeLoading extends UserHomeState {
  const UserHomeLoading();

  @override
  List<Object> get props => [];
}

class UserHomeError extends UserHomeState {
  final String message;

  const UserHomeError(this.message);

  @override
  List<Object> get props => [message];
}
class OffsetChanged extends UserHomeState {
  final double offset;

  OffsetChanged(this.offset);

  @override
  List<Object> get props => [offset];
}
