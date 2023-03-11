import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:muslim_app/shared/components/size_box.dart';

class RadioScreen extends StatelessWidget {
  static const String routeName = 'RadioScreen';
  const RadioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Space(
              height: 50.h,
              width: 0,
            ),
            Lottie.asset(
              'assets/lottie/radio.zip',
              width: 500.w,
              fit: BoxFit.fill,
            ),
            Lottie.asset(
              'assets/lottie/soon.zip',
              width: 200.w,
              fit: BoxFit.fill,
            )
          ],
        ),
      ),
    );
  }
}