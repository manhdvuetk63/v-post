import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());
}

@immutable
abstract class SignupState extends Equatable {
  const SignupState();
}

class SignupInitial extends SignupState {
  const SignupInitial();

  @override
  List<Object> get props => [];
}

class Signing extends SignupState {
  const Signing();

  @override
  List<Object> get props => [];
}

class Signed extends SignupState {
  const Signed();

  @override
  List<Object> get props => [];
}

class SignupError extends SignupState {
  final String message;

  const SignupError(this.message);

  @override
  List<Object> get props => [message];
}
