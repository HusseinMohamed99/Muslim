import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class DesktopScreen extends StatelessWidget {
  const DesktopScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
          child: Lottie.asset(
            'assets/lottie/soon.zip',
            width: 200,
            fit: BoxFit.fill,
          ),),
    );
  }
}