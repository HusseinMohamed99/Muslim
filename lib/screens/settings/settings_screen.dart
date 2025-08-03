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
    final settingsProvider = Provider.of<SettingsProvider>(context);
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(settingsProvider.getBackgroundImage()),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            S.of(context).settings,
            style: TextStyle(
              fontFamily: 'Elgharib',
              fontSize: getResponsiveFontSize(context, fontSize: 25.sp),
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TitleWidget(
                titleText: S.of(context).theme,
              ),
              const Space(width: 0, height: 8),
              CustomCardWidget(
                settingsProvider: settingsProvider,
                function: showThemeBottomSheet,
                titleText: settingsProvider.isDarkMode()
                    ? S.of(context).dark
                    : S.of(context).light,
                iconData: FontAwesomeIcons.solidMoon,
              ),
              const Space(width: 0, height: 24),
              TitleWidget(
                titleText: S.of(context).language,
              ),
              const Space(width: 0, height: 8),
              CustomCardWidget(
                settingsProvider: settingsProvider,
                function: showLanguageBottomSheet,
                titleText: settingsProvider.currentLanguage == 'en'
                    ? S.of(context).english
                    : S.of(context).arabic,
                iconData: FontAwesomeIcons.globe,
              ),
              const Space(width: 0, height: 24),
              TitleWidget(
                titleText: S.of(context).rating,
              ),
              const Space(width: 0, height: 8),
              CustomCardWidget(
                settingsProvider: settingsProvider,
                function: goToApplicationOnPlayStore,
                titleText: S.of(context).rating,
                iconData: FontAwesomeIcons.star,
              ),
              const Spacer(),
              Text(
                'Version: $appVersion',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Elgharib',
                  fontSize: getResponsiveFontSize(context, fontSize: 14.sp),
                  fontWeight: FontWeight.w400,
                  color: settingsProvider.isDarkMode()
                      ? Colors.white
                      : Colors.black,
                ),
              ),
              const Space(width: 0, height: 20),
            ],
          ),
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

void goToApplicationOnPlayStore() async {
  final PackageInfo packageInfo = await PackageInfo.fromPlatform();

  String url = '';
  final String packageName = packageInfo.packageName;
  if (Platform.isAndroid) {
    url = 'https://play.google.com/store/apps/details?id=$packageName';
    if (!await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }
}
