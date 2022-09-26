import 'package:flutter/material.dart';
import 'package:xchat/core/utils/app_strings.dart';
import 'package:xchat/presentation/screens/Sign%20Up/screen/signup_screen.dart';
import 'package:xchat/presentation/screens/login/screen/login_screen.dart';
import 'package:xchat/presentation/screens/onboard_screen.dart';

class Routes {
  static const String initialRoute = '/';
  static const String loginScreen = 'loginScreen';
  static const String signUpScreen = 'SignUpScreen';
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
