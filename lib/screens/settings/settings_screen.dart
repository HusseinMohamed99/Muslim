import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:muslim_app/shared/components/language_bottom_sheet.dart';
import 'package:muslim_app/shared/components/theme_bottom_sheet.dart';
import 'package:muslim_app/shared/components/size_box.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:muslim_app/shared/providers/settings_provider.dart';
import 'package:muslim_app/shared/style/theme.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);
  static const String routeName = 'SettingsScreen';

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsProvider>(context);
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(12).r,
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Text(
            AppLocalizations.of(context)!.theme,
            style: Theme.of(context).textTheme.subtitle2!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                ),
          ),
          Space(width: 0, height: 8.h),
          Card(
            color: settingsProvider.isDarkMode()
                ? ThemeApp.darkPrimary
                : ThemeApp.lightPrimary,
            child: Padding(
              padding: const EdgeInsets.all(8.0).r,
              child: InkWell(
                onTap: () {
                  showThemeBottomSheet();
                },
                child: Row(
                  children: [
                    Container(
                      width: 60.w,
                      height: 60.h,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        FontAwesomeIcons.solidMoon,
                        size: 50.sp,
                        color: Colors.black,
                      ),
                    ),
                    Space(width: 10.w, height: 0),
                    Text(
                      settingsProvider.isDarkMode()
                          ? AppLocalizations.of(context)!.dark
                          : AppLocalizations.of(context)!.light,
                      style: settingsProvider.currentLanguage == 'en'
                          ? Theme.of(context).textTheme.headline6
                          : Theme.of(context).textTheme.headline6!.copyWith(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.arrow_circle_down_sharp,
                      color: Colors.black,
                      size: 24.sp,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Space(width: 0, height: 24.h),
          Text(
            AppLocalizations.of(context)!.language,
            style: Theme.of(context).textTheme.subtitle2!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                ),
          ),
          Space(width: 0, height: 8.h),
          Card(
            color: settingsProvider.isDarkMode()
                ? ThemeApp.darkPrimary
                : ThemeApp.lightPrimary,
            child: Padding(
              padding: const EdgeInsets.all(8.0).r,
              child: InkWell(
                onTap: () {
                  showLanguageBottomSheet();
                },
                child: Row(
                  children: [
                    Container(
                      width: 60.w,
                      height: 60.h,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        FontAwesomeIcons.globe,
                        size: 50.sp,
                        color: Colors.black,
                      ),
                    ),
                    Space(
                      width: 10.w,
                      height: 0,
                    ),
                    Text(
                      settingsProvider.currentLanguage == 'en'
                          ? AppLocalizations.of(context)!.english
                          : AppLocalizations.of(context)!.arabic,
                      style: settingsProvider.currentLanguage == 'en'
                          ? Theme.of(context).textTheme.headline6
                          : Theme.of(context).textTheme.headline6!.copyWith(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.arrow_circle_down_sharp,
                      color: Colors.black,
                      size: 24.sp,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Space(width: 0, height: 24.h),
          Text(
            'GitHub',
            style: Theme.of(context).textTheme.subtitle2!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                ),
          ),
          Space(width: 0, height: 8.h),
          Card(
            color: settingsProvider.isDarkMode()
                ? ThemeApp.darkPrimary
                : ThemeApp.lightPrimary,
            child: Padding(
              padding: const EdgeInsets.all(8.0).r,
              child: InkWell(
                onTap: () {
                  Share.share('''*Muslim_app*\n
You can develop it from my GitHub https://github.com/HusseinMohamed99''');
                },
                child: Row(
                  children: [
                    Container(
                      width: 60.w,
                      height: 60.h,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        FontAwesomeIcons.github,
                        size: 50.sp,
                        color: Colors.black,
                      ),
                    ),
                    Space(width: 10.w, height: 0),
                    Text(
                      'GitHub',
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.arrow_circle_down_sharp,
                      color: Colors.black,
                      size: 24.sp,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Space(width: 0, height: 24.h),
          Text(
            'WebSite',
            style: Theme.of(context).textTheme.subtitle2!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                ),
          ),
          Space(
            width: 0,
            height: 8.h,
          ),
          Card(
            color: settingsProvider.isDarkMode()
                ? ThemeApp.darkPrimary
                : ThemeApp.lightPrimary,
            child: Padding(
              padding: const EdgeInsets.all(8.0).r,
              child: InkWell(
                onTap: () {
                  Share.share('''*My Portfolio*\n
You can connect with me from my Portfolio https://zaap.bio/HusseinMohamed''');
                },
                child: Row(
                  children: [
                    Container(
                      width: 60.w,
                      height: 60.h,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        FontAwesomeIcons.envelope,
                        size: 40.sp,
                        color: Colors.black,
                      ),
                    ),
                    Space(
                      width: 10.w,
                      height: 0,
                    ),
                    Text(
                      'My Portfolio',
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.arrow_circle_down_sharp,
                      color: Colors.black,
                      size: 24.sp,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  void showThemeBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (buildContext) {
        return const ThemeBottomSheet();
      },
    );
  }

  void showLanguageBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (buildContext) {
        return const LanguageBottomSheet();
      },
    );
  }
}
