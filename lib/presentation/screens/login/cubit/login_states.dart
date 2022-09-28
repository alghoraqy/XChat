import 'package:equatable/equatable.dart';

abstract class LoginStates extends Equatable {
  const LoginStates();

  @override
  List<Object?> get props => [];
}

class LoginInitState extends LoginStates {}

class LoginChangeSecure extends LoginStates {}

//// Login FireBase
class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final String uId;
  const LoginSuccessState({required this.uId});
}

class LoginErrorState extends LoginStates {
  final String message;
  const LoginErrorState({required this.message});
}
