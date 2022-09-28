import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String userName;
  final String email;
  final String phone;
  final String uId;

  const UserModel({
    required this.userName,
    required this.email,
    required this.phone,
    required this.uId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userName: json['userName'],
      email: json['email'],
      phone: json['phone'],
      uId: json['uId'],
    );
  }

  Map<String, dynamic> tomap() {
    return {
      'userName': userName,
      'email': email,
      'phone': phone,
      'uId': uId,
    };
  }

  @override
  List<Object?> get props => [
        userName,
        email,
        phone,
        uId,
      ];
}
