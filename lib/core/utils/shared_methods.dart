import 'package:flutter/material.dart';

Future navigateTo(context, String screenRoute) {
  return Navigator.pushNamed(context, screenRoute);
}

Future navigateAndFinish(context, String screenRoute) {
  return Navigator.pushReplacementNamed(context, screenRoute);
}
