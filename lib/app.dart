import 'package:flutter/material.dart';
import 'package:xchat/config/routes/app_routes.dart';
import 'package:xchat/presentation/screens/Sign%20Up/screen/signup_screen.dart';

class Xchat extends StatelessWidget {
  const Xchat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Montserrat'),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      home: const SignUpScreen(),
    );
  }
}
