import 'package:flutter/material.dart';
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
      create: (_) => SettingsProvider(),
      child: const MuslimApplication(),
    ),
  );
}

class MuslimApplication extends StatelessWidget {
  const MuslimApplication({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);
    _initializePreferences(settingsProvider);

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
          theme: ThemeApp.lightTheme,
          darkTheme: ThemeApp.darkTheme,
          themeMode: settingsProvider.currentTheme,
          debugShowCheckedModeBanner: false,
          routes: _buildAppRoutes(),
          initialRoute: HomeScreen.routeName,
        );
      },
    );
  }

  Map<String, WidgetBuilder> _buildAppRoutes() {
    return {
      HomeScreen.routeName: (_) => const HomeScreen(),
      QuranScreen.routeName: (_) => const QuranScreen(),
      SuraDetailsScreen.routeName: (_) => const SuraDetailsScreen(),
      HadithScreen.routeName: (_) => const HadithScreen(),
      HadithDetailsScreen.routeName: (_) => const HadithDetailsScreen(),
      SebhaScreen.routeName: (_) => const SebhaScreen(),
      SettingsScreen.routeName: (_) => const SettingsScreen(),
      RadioScreen.routeName: (_) => const RadioScreen(),
    };
  }

  Future<void> _initializePreferences(SettingsProvider settingsProvider) async {
    final pref = await SharedPreferences.getInstance();
    final language = pref.getString('Lang') ?? 'en';
    settingsProvider.changeLanguage(language);

    final theme = pref.getString('Theme');
    if (theme == 'Light') {
      settingsProvider.changeTheme(ThemeMode.light);
    } else if (theme == 'Dark') {
      settingsProvider.changeTheme(ThemeMode.dark);
    }
  }
}
