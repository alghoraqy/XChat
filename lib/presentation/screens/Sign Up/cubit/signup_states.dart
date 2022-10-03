import 'package:equatable/equatable.dart';

abstract class SignUpStates extends Equatable {
  const SignUpStates();
  @override
  List<Object?> get props => [];
}

class SignUpInitState extends SignUpStates {}

class SignUpLoadingState extends SignUpStates {}

class SignUpSuccessState extends SignUpStates {}

class SignUpErrorState extends SignUpStates {
  final String message;
  const SignUpErrorState({required this.message});
}

class CreateUserSuccessState extends SignUpStates {
  final String uId;
  const CreateUserSuccessState({required this.uId});
}

class CreateUserErrorState extends SignUpStates {
  final String message;
  const CreateUserErrorState({required this.message});
}

class PickProfileImageSuccess extends SignUpStates {}

class PickProfileImageError extends SignUpStates {}
