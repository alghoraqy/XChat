import 'package:equatable/equatable.dart';

abstract class AppStates extends Equatable {
  @override
  List<Object?> get props => [];
}

class AppInitState extends AppStates {}

class ChangeState extends AppStates {}

class ChangeBottomNavState extends AppStates {}

/// GET USER PROFILE

class GetUserProfileSuccess extends AppStates {}

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

/// UPLOAD PROFILE IMGE STATES 
class UploadProfileImageLoading extends AppStates{}
class UploadProfileImageSuccess extends AppStates{}
class UploadProfileImageError extends AppStates{}


class UpdateUserProfileLoading extends AppStates{}

/// SEND MESSAGES STATES
class SendMessageSuccess extends AppStates{} 
class SendMessageError extends AppStates{} 

/// GEET MEESSAGS STATES 
class GetMyMessagesSuccess extends AppStates{} 
class GetMyMessagesError extends AppStates{} 

class ChangeSearchState extends AppStates{} 


class CheckInternetSuccess extends AppStates{} 

