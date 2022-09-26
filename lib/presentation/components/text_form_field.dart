import 'package:flutter/material.dart';
import 'package:xchat/core/utils/responsive.dart';

class MyTextFormField extends StatelessWidget {
  final String labeltext;
  final String? Function(String? text)? validator;
  final TextInputType keyboardType;
  bool? isSecure;
  Widget? suffix;
  double? width;

  MyTextFormField({
    super.key,
    required this.labeltext,
    required this.validator,
    this.isSecure,
    this.suffix,
    this.width,
    required this.keyboardType,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? rwidth(context),
      child: TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          labelText: labeltext,
          suffixIcon: suffix,
        ),
        validator: validator,
        keyboardType: keyboardType,
        obscureText: isSecure ?? false,
      ),
    );
  }
}
