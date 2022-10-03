import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:xchat/models/user_model.dart';

import '../../core/utils/app_colors.dart';
import '../../core/utils/app_textstyle.dart';
import '../../core/utils/responsive.dart';
import 'message_screen_comp.dart';

class PeopleComponent extends StatelessWidget {
  final PeopleModel peopleModel;
  final VoidCallback onPressed;

  const PeopleComponent({
    super.key,
    required this.peopleModel,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Material(
        child: InkWell(
          onTap: onPressed,
          splashColor: AppColors.backgroundColor,
          highlightColor: AppColors.textColor.withOpacity(.2),
          child: Ink(
            height: rhight(context) / 10,
            width: rwidth(context),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.white),
            child: Row(
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleImage(
                      image: peopleModel.image,
                      width: rwidth(context) / 5,
                      hight: rhight(context) / 10,
                      margin: 4,
                    ),
                    Positioned(
                      top: rhight(context) / 14,
                      child: const CircleAvatar(
                        radius: 11,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 7,
                          backgroundColor: Colors.green,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  width: rwidth(context) / 30,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        peopleModel.name,
                        style: AppTextStyle.messageTitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
