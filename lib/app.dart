import 'package:flutter/material.dart';
import 'package:xchat/config/routes/app_routes.dart';

class Xchat extends StatelessWidget {
  final Widget startScreen;
  const Xchat({super.key, required this.startScreen});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Montserrat'),
      title: 'XChat',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      builder: (context, child) {
        return MediaQuery(data: MediaQuery.of(context).copyWith(textScaleFactor: 1), child: child!);
      },
      home: startScreen,
    );
  }
}
