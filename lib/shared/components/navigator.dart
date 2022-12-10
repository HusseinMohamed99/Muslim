import 'package:flutter/material.dart';

void pop(context) {
  Navigator.pop(context);
}

void navigateTo(context, {required String routeName, Object? arguments}) {
  Navigator.pushNamed(context, routeName, arguments: arguments);
}



void navigateAndFinish(
    context, {
      required String routeName,
      Object? arguments,
    }) {
  Navigator.pushNamedAndRemoveUntil(
      context, routeName, arguments: arguments, (route) => false);
}

