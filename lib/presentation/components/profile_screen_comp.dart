import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../core/utils/app_colors.dart';
import '../../core/utils/app_textstyle.dart';
import '../../core/utils/responsive.dart';
import 'message_screen_comp.dart';

class ProfileStack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleImage(
          image:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ4rsSzLimlQyniEtUV4-1raljzFhS45QBeAw&usqp=CAU',
          hight: rhight(context) / 4,
          width: rwidth(context) / 2.2,
        ),
        Positioned(
          bottom: rhight(context) / 60,
          left: rwidth(context) / 3.8,
          child: MaterialButton(
            onPressed: () {},
            height: rhight(context) / 16,
            color: AppColors.textColor.withOpacity(.8),
            elevation: 0,
            shape: CircleBorder(
              side: BorderSide(color: Colors.white, width: 4),
            ),
            child: Icon(
              Icons.add_a_photo_outlined,
              color: Colors.white,
              size: 26,
            ),
          ),
        )
      ],
    );
  }
}

class ProfileFormField extends StatelessWidget {
  final String hint;
  //final TextEditingController controller;
  const ProfileFormField({
    super.key,
    required this.hint,
    // required this.controller,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(20), boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(.5),
            blurRadius: 5,
            spreadRadius: 1,
            offset: const Offset(4.5, 4))
      ]),
      child: TextFormField(
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: hint,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none)),
      ),
    );
  }
}

class ProfileData extends StatelessWidget {
  final String text;
  ProfileData({required this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: rhight(context) / 13,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(.5),
                blurRadius: 5,
                spreadRadius: 1,
                offset: const Offset(4.5, 4))
          ]),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: rwidth(context) / 22),
        child: Row(
          children: [
            Expanded(
              child: Text(
                text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.messageTitle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
