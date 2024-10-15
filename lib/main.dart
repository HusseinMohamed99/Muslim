import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:muslim_app/core/helpers/export_manager/export_manager.dart';
import 'package:muslim_app/firebase_options.dart';
import 'package:muslim_app/screens/sebha/sebha_screen.dart';
import 'package:muslim_app/shared/providers/settings_provider.dart';
import 'package:muslim_app/shared/style/theme.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upgrader/upgrader.dart';
import 'package:url_launcher/url_launcher.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (kReleaseMode) {
    // Pass all uncaught "fatal" errors from the framework to Crashlytics
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

    // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }

  await ScreenUtil.ensureScreenSize();
  if (kReleaseMode) {
    await requestReview();
  }
  if (kDebugMode) {
    await Upgrader.clearSavedSettings();
  }
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
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: const TextScaler.linear(1.0),
          ),
          child: MaterialApp(
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
          ),
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

Future<void> requestReview() async {
  final InAppReview inAppReview = InAppReview.instance;

  if (await inAppReview.isAvailable()) {
    await inAppReview.requestReview();
  } else {
    goToApplicationOnPlayStore();
  }
}

goToApplicationOnPlayStore() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  String url = '';
  String packageName = packageInfo.packageName;
  if (Platform.isAndroid) {
    url = 'https://play.google.com/store/apps/details?id=$packageName';
  } else if (!await launchUrl(Uri.parse(url),
      mode: LaunchMode.externalApplication)) {
    throw Exception('Could not launch $url');
  }
}
