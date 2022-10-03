import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String userName;
  final String email;
  final String phone;
  final String image;
  final String uId;

  const UserModel({
    required this.userName,
    required this.email,
    required this.phone,
    required this.image,
    required this.uId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userName: json['userName'],
      email: json['email'],
      phone: json['phone'],
      image: json['image'],
      uId: json['uId'],
    );
  }

  Map<String, dynamic> tomap() {
    return {
      'userName': userName,
      'email': email,
      'phone': phone,
      'image': image,
      'uId': uId,
    };
  }

  @override
  List<Object?> get props => [
        userName,
        email,
        phone,
        image,
        uId,
      ];
}

class PeopleModel {
  final String name;
  final String image;
  PeopleModel({
    required this.image,
    required this.name,
  });
}
