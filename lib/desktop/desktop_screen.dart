import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DesktopScreen extends StatelessWidget {
  const DesktopScreen({Key? key}) : super(key: key);
  static const String routeName = 'DesktopScreen';

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body: Center(
          child: Text('Coming Soon',style: GoogleFonts.elMessiri(
            fontSize: 40
          ),),
          ),
    );
  }
}