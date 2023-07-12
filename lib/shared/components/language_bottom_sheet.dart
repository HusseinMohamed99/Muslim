import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:muslim_app/shared/components/size_box.dart';
import 'package:muslim_app/shared/providers/settings_provider.dart';
import 'package:muslim_app/shared/style/theme.dart';
import 'package:provider/provider.dart';

class LanguageBottomSheet extends StatefulWidget {
  const LanguageBottomSheet({super.key});

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsProvider>(context);
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
          color: settingsProvider.isDarkMode()
              ? const Color(0xff141922)
              : Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ).r),
      height: 200.h,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: () {
              settingsProvider.changeLanguage('en');
            },
            child: settingsProvider.currentLanguage == 'en'
                ? getSelectedItem(
                    AppLocalizations.of(context)!.english,
                  )
                : getUnselectedItem(
                    AppLocalizations.of(context)!.english,
                  ),
          ),
          Space(
            height: 12.h,
            width: 0,
          ),
          InkWell(
            onTap: () {
              settingsProvider.changeLanguage('ar');
            },
            child: settingsProvider.currentLanguage == 'ar'
                ? getSelectedItem(
                    AppLocalizations.of(context)!.arabic,
                  )
                : getUnselectedItem(
                    AppLocalizations.of(context)!.arabic,
                  ),
          )
        ],
      ),
    );
  }

  Widget getSelectedItem(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Provider.of<SettingsProvider>(context).isDarkMode()
                    ? ThemeApp.yellow
                    : ThemeApp.lightPrimary,
              ),
        ),
        Icon(
          FontAwesomeIcons.circleCheck,
          color: Provider.of<SettingsProvider>(context).isDarkMode()
              ? ThemeApp.yellow
              : ThemeApp.lightPrimary,
          size: 24.sp,
        )
      ],
    );
  }

  Widget getUnselectedItem(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}
