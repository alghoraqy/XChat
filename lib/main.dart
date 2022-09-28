import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:xchat/app.dart';
import 'package:xchat/core/network/local/cach_helper.dart';
import 'package:xchat/core/utils/constances.dart';
import 'package:xchat/presentation/screens/home/screen/home_screen.dart';
import 'package:xchat/presentation/screens/login/screen/login_screen.dart';
import 'package:xchat/presentation/screens/onboard_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await CachHelper.init();

  Widget? widget;
  Constances.onBoard = GetDataFromPrefs.getData(key: 'onBoard');
  Constances.uId = GetDataFromPrefs.getData(key: 'uId');
  if (Constances.onBoard == null) {
    widget = const OnBoardingScreen();
  } else {
    if (Constances.onBoard == true) {
      if (Constances.uId == null) {
        widget = const LoginScreen();
      } else {
        widget = const HomeScreen();
      }
    }
  }
  runApp(Xchat(
    startScreen: widget!,
  ));
}
