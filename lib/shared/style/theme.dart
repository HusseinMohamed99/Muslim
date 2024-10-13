import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeApp {
  static const Color lightPrimary = Color(0xffB7935F);
  static const Color darkPrimary = Color(0xff141A2E);
  static const Color yellow = Color(0xffFACC1D);

  // Common radius for the bottom sheet
  static final BorderRadius _bottomSheetRadius = const BorderRadius.only(
    topLeft: Radius.circular(18),
    topRight: Radius.circular(18),
  ).r;

  // Common system overlay style for both themes
  static const SystemUiOverlayStyle _systemOverlayStyle = SystemUiOverlayStyle(
    statusBarBrightness: Brightness.dark,
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  );

  // Light Theme
  static final ThemeData lightTheme = ThemeData(
    fontFamily: GoogleFonts.elMessiri().fontFamily,
    primaryColor: lightPrimary,
    scaffoldBackgroundColor: Colors.transparent,
    bottomSheetTheme: _bottomSheetTheme(Colors.white),
    cardColor: Colors.white,
    textTheme: _textTheme(Colors.black),
    appBarTheme: _appBarTheme(Colors.black),
    bottomNavigationBarTheme:
        _bottomNavigationBarTheme(Colors.black, Colors.white),
  );

  // Dark Theme
  static final ThemeData darkTheme = ThemeData(
    fontFamily: GoogleFonts.elMessiri().fontFamily,
    primaryColor: darkPrimary,
    scaffoldBackgroundColor: Colors.transparent,
    bottomSheetTheme: _bottomSheetTheme(darkPrimary),
    textTheme: _textTheme(Colors.white),
    appBarTheme: _appBarTheme(Colors.white),
    bottomNavigationBarTheme: _bottomNavigationBarTheme(yellow, Colors.white),
  );

  // Method to define text styles across the app
  static TextTheme _textTheme(Color color) {
    return TextTheme(
      titleLarge: TextStyle(fontSize: 32.sp, color: color),
      headlineMedium: TextStyle(fontSize: 28.sp, color: color),
      titleSmall: TextStyle(fontSize: 14.sp, color: color),
    );
  }

  // Method to define AppBar theme across the app
  static AppBarTheme _appBarTheme(Color color) {
    return AppBarTheme(
      centerTitle: true,
      color: Colors.transparent,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: color,
        fontSize: 32.sp,
        fontWeight: FontWeight.w500,
      ),
      iconTheme: IconThemeData(color: color, size: 24.sp),
      systemOverlayStyle: _systemOverlayStyle,
    );
  }

  // Method to define BottomSheet theme across the app
  static BottomSheetThemeData _bottomSheetTheme(Color backgroundColor) {
    return BottomSheetThemeData(
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: _bottomSheetRadius),
    );
  }

  // Method to define BottomNavigationBar theme across the app
  static BottomNavigationBarThemeData _bottomNavigationBarTheme(
      Color selectedColor, Color unselectedColor) {
    return BottomNavigationBarThemeData(
      selectedLabelStyle: TextStyle(
        fontWeight: FontWeight.bold,
        color: selectedColor,
      ),
      unselectedLabelStyle: TextStyle(
        color: unselectedColor,
        fontWeight: FontWeight.bold,
      ),
      showSelectedLabels: true,
      showUnselectedLabels: false,
      selectedIconTheme: IconThemeData(size: 34.sp, color: selectedColor),
      unselectedIconTheme: IconThemeData(size: 30.sp, color: unselectedColor),
      selectedItemColor: selectedColor,
    );
  }
}
