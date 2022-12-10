import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemeApp {
  static const Color lightPrimary = Color(0xffB7935F);
  static const Color darkPrimary = Color(0xff141A2E);
  static const Color yellow = Color(0xffFACC1D);

  static final ThemeData lightTheme = ThemeData(
    primaryColor: lightPrimary,
    scaffoldBackgroundColor: Colors.transparent,
    bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18), topRight: Radius.circular(18)))),
    cardColor: Colors.white,
    accentColor: lightPrimary,
    textTheme: const TextTheme(
        headline6: TextStyle(
          fontSize: 32,
          color: Colors.black,
        ),
        headline4: TextStyle(
          fontSize: 28,
          color: Colors.black,
        ),
        subtitle2: TextStyle(fontSize: 14, color: Colors.black)),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
      color: Colors.transparent,
      titleTextStyle: TextStyle(
          color: Colors.black, fontSize: 32, fontWeight: FontWeight.w500),
      iconTheme: IconThemeData(color: Colors.black),
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark),
      actionsIconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        showSelectedLabels: true,
        showUnselectedLabels: false,
        selectedIconTheme: IconThemeData(size: 36, color: Colors.black),
        unselectedIconTheme: IconThemeData(size: 30, color: Colors.white),
        selectedLabelStyle: TextStyle(color: Colors.black),
        selectedItemColor: Colors.black),
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.transparent,
    primaryColor: darkPrimary,
    accentColor: yellow,
    bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: darkPrimary,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18), topRight: Radius.circular(18)))),
    textTheme: const TextTheme(
        headline6: TextStyle(
          fontSize: 22,
          color: Colors.white,
        ),
        headline4: TextStyle(
          fontSize: 28,
          color: Colors.white,
        ),
        subtitle2: TextStyle(fontSize: 14, color: Colors.white)),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      color: Colors.transparent,
      elevation: 0,
      titleTextStyle: TextStyle(
          color: Colors.white, fontSize: 32, fontWeight: FontWeight.w500),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        showSelectedLabels: true,
        showUnselectedLabels: false,
        selectedIconTheme: IconThemeData(size: 36, color: yellow),
        unselectedIconTheme: IconThemeData(size: 30, color: Colors.white),
        selectedLabelStyle: TextStyle(color: yellow),
        selectedItemColor: yellow),
  );
}
