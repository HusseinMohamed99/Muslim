import 'package:flutter/material.dart';
import 'package:muslim_app/shared/image_path/image_path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  ThemeMode currentTheme = ThemeMode.light;
  String currentLanguage = 'en';

  Future<void> _updatePreferences(String key, String value) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString(key, value);
  }

  void changeLanguage(String newLanguage) async {
    if (currentLanguage != newLanguage) {
      currentLanguage = newLanguage;
      await _updatePreferences('Lang', currentLanguage);
      notifyListeners();
    }
  }

  void changeTheme(ThemeMode newMode) async {
    if (newMode != currentTheme) {
      currentTheme = newMode;
      final themeValue = currentTheme == ThemeMode.light ? 'Light' : 'Dark';
      await _updatePreferences('Theme', themeValue);
      notifyListeners();
    }
  }

  bool isDarkMode() => currentTheme == ThemeMode.dark;

  void refreshApp() => notifyListeners();

  String getBackgroundImage() {
    return isDarkMode()
        ? AssetsPath.assetsImagesBackgroundDark
        : AssetsPath.assetsImagesBackgroundLight;
  }
}
