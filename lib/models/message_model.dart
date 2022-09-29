import 'package:equatable/equatable.dart';

class MessageModel extends Equatable {
  final String image;
  final String name;
  final String messageBody;
  final String lastDate;

  const MessageModel({
    required this.image,
    required this.name,
    required this.messageBody,
    required this.lastDate,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      image: json['image'],
      name: json['name'],
      messageBody: json['messageBody'],
      lastDate: json['lastDate'],
    );
  }

  @override
  List<Object?> get props => [image, name, messageBody, lastDate];
}
