import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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
            return const MyApp();
          },
        )),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsProvider>(context);
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
        if (constraints.minWidth.toInt() <= 480) {
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
  }
}
