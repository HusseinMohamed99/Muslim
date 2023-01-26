import 'package:flutter/material.dart';
import 'package:muslim_app/shared/image_path/image_path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  ThemeMode currentTheme = ThemeMode.light;
  String currentLanguage = 'en';

  void changeLanguage(String newLanguage)async {
    final pref =await SharedPreferences.getInstance();
    if(currentLanguage == newLanguage)return;
    currentLanguage = newLanguage;
    pref.setString("Lang", currentLanguage);
    notifyListeners();
  }

  void changeTheme(ThemeMode newMode)async {
    final pref =await SharedPreferences.getInstance();
    if (newMode == currentTheme)return;
    currentTheme = newMode;
    pref.setString("Theme", currentTheme == ThemeMode.light ? "Light" : "Dark");
    notifyListeners();
  }
  bool isDarkMode() {
    return currentTheme == ThemeMode.dark;
  }

  void refreshApp() {
    notifyListeners();
  }

  String getBackgroundImage() {
    return currentTheme == ThemeMode.light
        ? AssetsPath.backgroundLight
        : AssetsPath.backgroundDark;
  }
}

