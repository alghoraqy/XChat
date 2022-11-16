import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:xchat/app.dart';
import 'package:xchat/core/network/local/cach_helper.dart';
import 'package:xchat/core/utils/constances.dart';
import 'package:xchat/presentation/screens/home/screen/layout/home_screen.dart';
import 'package:xchat/presentation/screens/login/screen/login_screen.dart';
import 'package:xchat/presentation/screens/OnBoard/onboard_screen.dart';

const bool useEmulator = false;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
   if (useEmulator) {
    await _connectToFirebaseEmulator();
  }
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

Future _connectToFirebaseEmulator () async{
  final localHostString = Platform.isAndroid?'10.0.2.2':'localhost';
  FirebaseFirestore.instance.settings = Settings(
    host: '$localHostString:8080',
    sslEnabled: false,
    persistenceEnabled:  false,
  );
  await FirebaseAuth.instance.useAuthEmulator(localHostString,9099);
}