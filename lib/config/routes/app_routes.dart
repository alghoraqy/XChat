import 'package:flutter/material.dart';
import 'package:xchat/core/utils/app_strings.dart';
import 'package:xchat/presentation/screens/Sign%20Up/screen/signup_screen.dart';
import 'package:xchat/presentation/screens/home/screen/layout/home_screen.dart';
import 'package:xchat/presentation/screens/login/screen/login_screen.dart';
import 'package:xchat/presentation/screens/OnBoard/onboard_screen.dart';

class Routes {
  static const String initialRoute = 'onBoarding';
  static const String loginScreen = 'loginScreen';
  static const String signUpScreen = 'SignUpScreen';
  static const String homeScreen = 'HomeScreen';
}

class AppRoutes {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(
            builder: (context) => const OnBoardingScreen());

      case Routes.loginScreen:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case Routes.signUpScreen:
        return MaterialPageRoute(builder: (context) => const SignUpScreen());
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (context) => const HomeScreen());

      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
        builder: (context) => const Scaffold(
              body: Center(
                child: Text(AppStrings.unDefinedRoute),
              ),
            ));
  }
}
