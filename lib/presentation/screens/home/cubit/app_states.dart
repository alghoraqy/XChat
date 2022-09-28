import 'package:equatable/equatable.dart';

abstract class AppStates extends Equatable {
  @override
  List<Object?> get props => [];
}

class AppInitState extends AppStates {}

class ChangeState extends AppStates {}
