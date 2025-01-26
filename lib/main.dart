import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim_app/core/helpers/constant.dart';
import 'package:muslim_app/core/helpers/dio_helper.dart';
import 'package:muslim_app/firebase_options.dart';
import 'package:muslim_app/muslim_app.dart';
import 'package:muslim_app/shared/providers/settings_provider.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Initialize Dio helper and Bloc observer
  await DioHelper.init();
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
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  appVersion = packageInfo.version;

  await ScreenUtil.ensureScreenSize();

  runApp(
    ChangeNotifierProvider(
      create: (_) => SettingsProvider(),
      child: const MuslimApplication(),
    ),
  );
}
