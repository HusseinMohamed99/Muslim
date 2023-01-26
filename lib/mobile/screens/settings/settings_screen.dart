import 'package:flutter/material.dart';
import 'package:muslim_app/shared/components/language_bottom_sheet.dart';
import 'package:muslim_app/shared/components/theme_bottom_sheet.dart';
import 'package:muslim_app/shared/components/size_box.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:muslim_app/shared/providers/settings_provider.dart';
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
    return Container(
      padding: const EdgeInsets.all(12),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Text(
          AppLocalizations.of(context)!.theme,
          style: Theme.of(context)
              .textTheme
              .subtitle2!
              .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const Space(width: 0, height: 8),
        InkWell(
          onTap: () {
            showThemeBottomSheet();
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                border:
                    Border.all(color: Theme.of(context).accentColor, width: 1)),
            child: Text(
              settingsProvider.isDarkMode()
                  ? AppLocalizations.of(context)!.dark
                  : AppLocalizations.of(context)!.light,
              style: settingsProvider.currentLanguage == 'en'
                  ? Theme.of(context).textTheme.headline4
                  : Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        Text(
          AppLocalizations.of(context)!.language,
          style: Theme.of(context)
              .textTheme
              .subtitle2!
              .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const SizedBox(
          height: 8,
        ),
        InkWell(
          onTap: () {
            showLanguageBottomSheet();
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                border:
                    Border.all(color: Theme.of(context).accentColor, width: 1)),
            child: Text(
              settingsProvider.currentLanguage == 'en'
                  ? AppLocalizations.of(context)!.english
                  : AppLocalizations.of(context)!.arabic,
              style: settingsProvider.currentLanguage == 'en'
                  ? Theme.of(context).textTheme.headline4
                  : Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        Text(
          'GitHub',
          style: Theme.of(context)
              .textTheme
              .subtitle2!
              .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const SizedBox(
          height: 8,
        ),
        InkWell(
          onTap: () {
            Share.share('''*Task-Management*\n
u can develop it from my github github.com/HusseinMohamed99''');
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                border:
                    Border.all(color: Theme.of(context).accentColor, width: 1)),
            child: Text(
              'GitHub',
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ),
      ]),
    );
  }

  void showThemeBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (buildContext) {
          return const ThemeBottomSheet();
        });
  }

  void showLanguageBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (buildContext) {
          return const LanguageBottomSheet();
        });
  }
}
