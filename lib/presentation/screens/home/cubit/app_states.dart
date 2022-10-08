import 'package:equatable/equatable.dart';

abstract class AppStates extends Equatable {
  @override
  List<Object?> get props => [];
}

class AppInitState extends AppStates {}

class ChangeState extends AppStates {}

class ChangeBottomNavState extends AppStates {}

/// GET USER PROFILE

class GetUserProfileSucces extends AppStates {}

class GetUserProfileError extends AppStates {
  final String message;
  GetUserProfileError({required this.message});
}

/// GET IMAGE PROFILE
class PickProfileImageLoading extends AppStates {}

class PickProfileImageSuccess extends AppStates {}

class PickProfileImageError extends AppStates {}

/// GET ALL USERS STATES
class GetAllUsersSuccess extends AppStates {}

class GetAllUsersError extends AppStates {
  final String message;
  GetAllUsersError({required this.message});
}
