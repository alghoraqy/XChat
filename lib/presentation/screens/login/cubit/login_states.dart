import 'package:equatable/equatable.dart';

abstract class LoginStates extends Equatable {
  const LoginStates();

  @override
  List<Object?> get props => [];
}

class LoginInitState extends LoginStates {}

class LoginChangeSecure extends LoginStates {}
