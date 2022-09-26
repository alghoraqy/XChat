import 'package:equatable/equatable.dart';

abstract class SignUpStates extends Equatable {
  const SignUpStates();
  @override
  List<Object?> get props => [];
}

class SignUpInitState extends SignUpStates {}
