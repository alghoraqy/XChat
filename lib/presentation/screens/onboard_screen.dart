import 'package:flutter/material.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';
import 'package:xchat/config/routes/app_routes.dart';
import 'package:xchat/core/network/local/cach_helper.dart';
import 'package:xchat/core/utils/shared_methods.dart';
import 'package:xchat/core/utils/app_colors.dart';
import 'package:xchat/core/utils/app_textstyle.dart';
import 'package:xchat/core/utils/assets_manager.dart';
import 'package:xchat/core/utils/responsive.dart';

import '../../core/utils/app_strings.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  bool isFinished = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(ImgAsset.backgroung), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: rhight(context) / 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.message_outlined,
                    color: Colors.white,
                    size: 28,
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Text(
                    AppStrings.appName,
                    style: AppTextStyle.textAppNamestyle,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: rhight(context) / 2.4,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25)),
                        color: Colors.white),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: rhight(context) / 20,
                          horizontal: rwidth(context) / 15),
                      child: Column(
                        children: [
                          Text(
                            AppStrings.onBoardingText,
                            textAlign: TextAlign.center,
                            style: AppTextStyle.onBoardingText,
                          ),
                          SizedBox(
                            height: rhight(context) / 50,
                          ),
                          Text(
                            AppStrings.onBoardingText2,
                            textAlign: TextAlign.center,
                            style: AppTextStyle.onBoardingText2,
                          ),
                          SizedBox(
                            height: rhight(context) / 20,
                          ),
                          Container(
                            width: rwidth(context) / 1.3,
                            child: SwipeableButtonView(
                                onFinish: () async {
                                  debugPrint('open');
                                  SaveDataToPrefs.saveData(
                                      key: 'onBoard', value: true);
                                  await navigateAndFinish(
                                      context, Routes.loginScreen);
                                },
                                onWaitingProcess: () {
                                  setState(() {
                                    isFinished = true;
                                  });
                                },
                                activeColor: Colors.blue.shade900,
                                isFinished: isFinished,
                                buttonWidget: Container(
                                  height: rhight(context) / 8,
                                  child: Icon(
                                    Icons.keyboard_double_arrow_right_outlined,
                                    color: AppColors.baseColor,
                                    size: 35,
                                  ),
                                ),
                                buttonText: 'Swipe to start ...'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
