import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:muslim_app/shared/components/language_bottom_sheet.dart';
import 'package:muslim_app/shared/components/size_box.dart';
import 'package:muslim_app/shared/components/theme_bottom_sheet.dart';
import 'package:muslim_app/shared/providers/settings_provider.dart';
import 'package:muslim_app/shared/style/theme.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TitleWidget(
              titleText: AppLocalizations.of(context)!.theme,
            ),
            Space(width: 0, height: 8.h),
            CustomCardWidget(
              settingsProvider: settingsProvider,
              function: showThemeBottomSheet,
              titleText: settingsProvider.isDarkMode()
                  ? AppLocalizations.of(context)!.dark
                  : AppLocalizations.of(context)!.light,
              iconData: FontAwesomeIcons.solidMoon,
            ),
            Space(width: 0, height: 24.h),
            TitleWidget(
              titleText: AppLocalizations.of(context)!.language,
            ),
            Space(width: 0, height: 8.h),
            CustomCardWidget(
              settingsProvider: settingsProvider,
              function: showLanguageBottomSheet,
              titleText: settingsProvider.currentLanguage == 'en'
                  ? AppLocalizations.of(context)!.english
                  : AppLocalizations.of(context)!.arabic,
              iconData: FontAwesomeIcons.globe,
            ),
          ],
        ),
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

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    super.key,
    required this.titleText,
  });
  final String titleText;
  @override
  Widget build(BuildContext context) {
    return Text(
      titleText,
      style: Theme.of(context).textTheme.titleSmall!.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
          ),
    );
  }
}

class CustomCardWidget extends StatelessWidget {
  const CustomCardWidget(
      {super.key,
      required this.settingsProvider,
      required this.function,
      required this.titleText,
      required this.iconData});
  final SettingsProvider settingsProvider;
  final VoidCallback function;
  final String titleText;
  final IconData iconData;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: settingsProvider.isDarkMode()
          ? ThemeApp.darkPrimary
          : ThemeApp.lightPrimary,
      child: Padding(
        padding: const EdgeInsets.all(8.0).r,
        child: InkWell(
          onTap: function,
          child: Row(
            children: [
              Container(
                width: 55,
                height: 55,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  iconData,
                  size: 24.sp,
                  color: Colors.black,
                ),
              ),
              Space(
                width: 10.w,
                height: 0,
              ),
              Text(
                titleText,
                style: settingsProvider.currentLanguage == 'en'
                    ? Theme.of(context).textTheme.titleLarge
                    : Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
              ),
              const Spacer(),
              Icon(
                Icons.arrow_circle_down_sharp,
                color: Colors.white,
                size: 24.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
