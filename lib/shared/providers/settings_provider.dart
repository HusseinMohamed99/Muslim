import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:muslim_app/core/helpers/dio_helper.dart';
import 'package:muslim_app/model/radio_model.dart';
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

  List<Radios>? radios = [];
  Radios? currentRadio;
  int currentIndex = 0;
  bool isRadioPlay = false;
  final radioPlayer = AudioPlayer();

  void getRadio() async {
    await DioHelper.getData(
      url: radio,
    ).then((value) {
      final data = RadioModel.fromJson(value.data);
      radios = data.radios;
      currentRadio = radios![currentIndex];
      notifyListeners();
    }).catchError((error) {
      log('Error: $error');
    });
  }
}
