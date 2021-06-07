part of 'profile.cubit.dart';

@immutable
abstract class ProfileState extends Equatable {
  const ProfileState();
}

class ProfileInitial extends ProfileState {
  const ProfileInitial();

  @override
  List<Object> get props => [];
}
class Loading extends ProfileState {
  const Loading();

  @override
  List<Object> get props => [];
}
class Loaded extends ProfileState {
  const Loaded();

  @override
  List<Object> get props => [];
}
class LoadFalse extends ProfileState {
  const LoadFalse();

  @override
  List<Object> get props => [];
}
