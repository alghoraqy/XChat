import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future navigateTo(context, String screenRoute) {
  return Navigator.pushNamed(context, screenRoute);
}

Future navigateAndFinish(context, String screenRoute) {
  return Navigator.pushReplacementNamed(context, screenRoute);
}

Future<bool?> showToast({
  required String message,
  required Color color,
}) async {
  return await Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0);
}
