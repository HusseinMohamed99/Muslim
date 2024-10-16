part of './../../core/helpers/export_manager/export_manager.dart';

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
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TitleWidget(
            titleText: AppLocalizations.of(context)!.theme,
          ),
          const Space(width: 0, height: 8),
          CustomCardWidget(
            settingsProvider: settingsProvider,
            function: showThemeBottomSheet,
            titleText: settingsProvider.isDarkMode()
                ? AppLocalizations.of(context)!.dark
                : AppLocalizations.of(context)!.light,
            iconData: FontAwesomeIcons.solidMoon,
          ),
          const Space(width: 0, height: 24),
          TitleWidget(
            titleText: AppLocalizations.of(context)!.language,
          ),
          const Space(width: 0, height: 8),
          CustomCardWidget(
            settingsProvider: settingsProvider,
            function: showLanguageBottomSheet,
            titleText: settingsProvider.currentLanguage == 'en'
                ? AppLocalizations.of(context)!.english
                : AppLocalizations.of(context)!.arabic,
            iconData: FontAwesomeIcons.globe,
          ),
          const Space(width: 0, height: 24),
          TitleWidget(
            titleText: AppLocalizations.of(context)!.rating,
          ),
          const Space(width: 0, height: 8),
          CustomCardWidget(
            settingsProvider: settingsProvider,
            function: goToApplicationOnPlayStore,
            titleText: AppLocalizations.of(context)!.rating,
            iconData: FontAwesomeIcons.star,
          ),
        ],
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

void goToApplicationOnPlayStore() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  String url = '';
  String packageName = packageInfo.packageName;
  if (Platform.isAndroid) {
    url = 'https://play.google.com/store/apps/details?id=$packageName';
    if (!await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }
}
