import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim_app/screens/hadith/hadith_details_screen.dart';
import 'package:muslim_app/screens/hadith/hadith_screen.dart';
import 'package:muslim_app/screens/home/home_screen.dart';
import 'package:muslim_app/screens/quran/quran_screen.dart';
import 'package:muslim_app/screens/quran/sura_details_screen.dart';
import 'package:muslim_app/screens/radio/radio_screen.dart';
import 'package:muslim_app/screens/sebha/sebha_screen.dart';
import 'package:muslim_app/screens/settings/settings_screen.dart';
import 'package:muslim_app/shared/providers/settings_provider.dart';
import 'package:muslim_app/shared/style/theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  runApp(
    ChangeNotifierProvider(
      create: (buildContext) => SettingsProvider(),
      child: Builder(
        builder: (context) {
          SystemChrome.setPreferredOrientations(
            [
              DeviceOrientation.portraitUp,
              DeviceOrientation.portraitDown,
            ],
          );
          return MuslimApp();
        },
      ),
    ),
  );
}

class MuslimApp extends StatelessWidget {
  MuslimApp({super.key});

  late SettingsProvider settingsProvider;

  @override
  Widget build(BuildContext context) {
    settingsProvider = Provider.of<SettingsProvider>(context);
    getValueFromPref();
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          locale: Locale(
            settingsProvider.currentLanguage,
          ),
          theme: ThemeApp.lightTheme,
          darkTheme: ThemeApp.darkTheme,
          themeMode: settingsProvider.currentTheme,
          debugShowCheckedModeBanner: false,
          routes: {
            HomeScreen.routeName: (_) => const HomeScreen(),
            QuranScreen.routeName: (_) => const QuranScreen(),
            SuraDetailsScreen.routeName: (_) => const SuraDetailsScreen(),
            HadithScreen.routeName: (_) => const HadithScreen(),
            HadithDetailsScreen.routeName: (_) => const HadithDetailsScreen(),
            SebhaScreen.routeName: (_) => const SebhaScreen(),
            SettingsScreen.routeName: (_) => const SettingsScreen(),
            RadioScreen.routeName: (_) => const RadioScreen(),
          },
          initialRoute: HomeScreen.routeName,
        );
      },
    );
  }

  getValueFromPref() async {
    final pref = await SharedPreferences.getInstance();
    settingsProvider.changeLanguage(pref.getString('Lang') ?? 'en');

    if (pref.getString('Theme') == 'Light') {
      settingsProvider.changeTheme(ThemeMode.light);
    } else if (pref.getString('Theme') == 'Dark') {
      settingsProvider.changeTheme(ThemeMode.dark);
    }
  }
}
