import 'package:flutter/material.dart';
import 'package:xchat/core/utils/app_colors.dart';

class MyButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final double hight;
  final double width;

  const MyButton({super.key, 
    required this.child,
    required this.onPressed,
    required this.hight,
    required this.width,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: MaterialButton(
        height: hight,
        onPressed: onPressed,
        color: AppColors.baseColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: child,
      ),
    );
  }
}
