import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeApp {
  static const Color lightPrimary = Color(0xffB7935F);
  static const Color darkPrimary = Color(0xff141A2E);
  static const Color yellow = Color(0xffFACC1D);

  static final ThemeData lightTheme = ThemeData(
    fontFamily: GoogleFonts.elMessiri().fontFamily,
    primaryColor: lightPrimary,
    scaffoldBackgroundColor: Colors.transparent,
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
        ).r,
      ),
    ),
    cardColor: Colors.white,
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 32.sp,
        color: Colors.black,
      ),
      headlineMedium: TextStyle(
        fontSize: 28.sp,
        color: Colors.black,
      ),
      titleSmall: TextStyle(
        fontSize: 14.sp,
        color: Colors.black,
      ),
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      centerTitle: true,
      color: Colors.transparent,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 32.sp,
        fontWeight: FontWeight.w500,
      ),
      iconTheme: IconThemeData(
        color: Colors.black,
        size: 24.sp,
      ),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      actionsIconTheme: IconThemeData(
        color: Colors.white,
        size: 24.sp,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      showSelectedLabels: true,
      showUnselectedLabels: false,
      selectedIconTheme: IconThemeData(
        size: 36.sp,
        color: Colors.black,
      ),
      unselectedIconTheme: IconThemeData(
        size: 30.sp,
        color: Colors.white,
      ),
      selectedLabelStyle: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      unselectedLabelStyle: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      selectedItemColor: Colors.black,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    fontFamily: GoogleFonts.elMessiri().fontFamily,
    scaffoldBackgroundColor: Colors.transparent,
    primaryColor: darkPrimary,
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: darkPrimary,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
        ).r,
      ),
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 22.sp,
        color: Colors.white,
      ),
      headlineMedium: TextStyle(
        fontSize: 28.sp,
        color: Colors.white,
      ),
      titleSmall: TextStyle(
        fontSize: 14.sp,
        color: Colors.white,
      ),
    ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: Colors.transparent,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 32.sp,
        fontWeight: FontWeight.w500,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        color: yellow,
      ),
      unselectedLabelStyle: const TextStyle(
        color: yellow,
        fontWeight: FontWeight.bold,
      ),
      showSelectedLabels: true,
      showUnselectedLabels: false,
      selectedIconTheme: IconThemeData(
        size: 36.sp,
        color: yellow,
      ),
      unselectedIconTheme: IconThemeData(
        size: 30.sp,
        color: Colors.white,
      ),
      selectedItemColor: yellow,
    ),
  );
}
