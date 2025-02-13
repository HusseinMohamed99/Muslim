import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:muslim_app/core/helpers/constant.dart';
import 'package:muslim_app/core/helpers/dio_helper.dart';
import 'package:muslim_app/firebase_options.dart';
import 'package:muslim_app/muslim_app.dart';
import 'package:muslim_app/shared/providers/settings_provider.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

void main() async {
  SentryWidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await MobileAds.instance.initialize();
  await ScreenUtil.ensureScreenSize();
  await DioHelper.init();
  await dotenv.load(fileName: '.env');

  if (kReleaseMode) {
    await SentryFlutter.init(
      (options) {
        options.dsn = dotenv.env['sentryKey'];
        options.tracesSampleRate = 0.01;
      },
      appRunner: () => runApp(
        ChangeNotifierProvider(
          create: (_) => SettingsProvider(),
          child: const MuslimApplication(),
        ),
      ),
    );
  } else {
    runApp(
      ChangeNotifierProvider(
        create: (_) => SettingsProvider(),
        child: const MuslimApplication(),
      ),
    );
  }
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  appVersion = packageInfo.version;
  appPackageName = packageInfo.packageName;
}
