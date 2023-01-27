import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim_app/desktop/desktop_screen.dart';
import 'package:muslim_app/mobile/screens/hadith/hadith_details_screen.dart';
import 'package:muslim_app/mobile/screens/hadith/hadith_screen.dart';
import 'package:muslim_app/mobile/screens/home/home_screen.dart';
import 'package:muslim_app/mobile/screens/quran/quran_screen.dart';
import 'package:muslim_app/mobile/screens/quran/sura_details_screen.dart';
import 'package:muslim_app/mobile/screens/radio/radio_screen.dart';
import 'package:muslim_app/mobile/screens/sebha/sebha_screen.dart';
import 'package:muslim_app/mobile/screens/settings/settings_screen.dart';
import 'package:muslim_app/shared/providers/settings_provider.dart';
import 'package:muslim_app/shared/style/theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ChangeNotifierProvider(
      create: (buildContext) => SettingsProvider(),
      child: Builder(
        builder: (context) {
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
          ]);
          return MyApp();
        },
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  late SettingsProvider settingsProvider;

  // This widget is the root of your application.
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
            locale: Locale(settingsProvider.currentLanguage),

            ///OR
            // supportedLocales: const [
            //   Locale('en', ''), // English, no country code
            //   Locale('ar', ''), // Spanish, no country code
            // ],
            theme: ThemeApp.lightTheme,
            darkTheme: ThemeApp.darkTheme,
            themeMode: settingsProvider.currentTheme,
            debugShowCheckedModeBanner: false,
            home: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              if (kDebugMode) {
                print(constraints.minWidth.toInt());
              }
              if (constraints.minWidth.toInt() <= 500) {
                return const HomeScreen();
              }
              return const DesktopScreen();
            }),

            routes: {
              HomeScreen.routeName: (_) => const HomeScreen(),
              QuranScreen.routeName: (_) => const QuranScreen(),
              SuraDetailsScreen.routeName: (_) => const SuraDetailsScreen(),
              HadithScreen.routeName: (_) => const HadithScreen(),
              HadithDetailsScreen.routeName: (_) => const HadithDetailsScreen(),
              SebhaScreen.routeName: (_) => const SebhaScreen(),
              SettingsScreen.routeName: (_) => const SettingsScreen(),
              RadioScreen.routeName: (_) => const RadioScreen(),
              DesktopScreen.routeName: (_) => const DesktopScreen(),
            },
            initialRoute: '/',
          );
        });
  }

  getValueFromPref() async {
    final pref = await SharedPreferences.getInstance();
    settingsProvider.changeLanguage(pref.getString("Lang") ?? "Light");

    if (pref.getString("Theme") == "Light") {
      settingsProvider.changeTheme(ThemeMode.light);
    } else if (pref.getString("Theme") == "Dark") {
      settingsProvider.changeTheme(ThemeMode.dark);
    }
  }
}
