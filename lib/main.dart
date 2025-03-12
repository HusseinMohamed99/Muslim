import 'package:firebase_core/firebase_core.dart';
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
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await ScreenUtil.ensureScreenSize();
  await DioHelper.init();

  runApp(
    ChangeNotifierProvider(
      create: (_) => SettingsProvider(),
      child: const MuslimApplication(),
    ),
  );

  final PackageInfo packageInfo = await PackageInfo.fromPlatform();
  appVersion = packageInfo.version;
  appPackageName = packageInfo.packageName;
}
