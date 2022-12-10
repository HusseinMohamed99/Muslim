import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class RadioScreen extends StatelessWidget {
  static const String routeName = 'RadioScreen';
  const RadioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Lottie.asset(
              'assets/lottie/radio.zip',
              width: 500,
              fit: BoxFit.fill,
            ),
            Lottie.asset(
              'assets/lottie/soon.zip',
              width: 200,
              fit: BoxFit.fill,
            )
          ],
        ),
      ),
    );
  }
}