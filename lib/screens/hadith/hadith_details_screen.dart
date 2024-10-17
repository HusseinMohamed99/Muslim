part of './../../core/helpers/export_manager/export_manager.dart';

class HadithDetailsScreen extends StatelessWidget {
  const HadithDetailsScreen({super.key});
  static const String routeName = 'HadithDetailsScreen';

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);
    final HadithDetailsArg argNames =
        ModalRoute.of(context)?.settings.arguments as HadithDetailsArg;

    final bool isDarkMode = settingsProvider.isDarkMode();
    final Color backgroundColor = isDarkMode ? Colors.white : Colors.black;
    final Color cardColor =
        isDarkMode ? Theme.of(context).primaryColor : Colors.white;

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(settingsProvider.getBackgroundImage()),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            AppLocalizations.of(context)!.app_title,
            style: GoogleFonts.elMessiri(
              fontSize: getResponsiveFontSize(context, fontSize: 25.sp),
            ),
          ),
        ),
        body: _buildBody(
          context,
          settingsProvider,
          argNames,
          cardColor,
          backgroundColor,
          isDarkMode,
        ),
      ),
    );
  }

  Widget _buildBody(
      BuildContext context,
      SettingsProvider settingsProvider,
      HadithDetailsArg argNames,
      Color cardColor,
      backgroundColor,
      bool isDarkMode) {
    return argNames.content.isEmpty
        ? const Center(child: AdaptiveIndicator())
        : SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Card(
              color: cardColor,
              elevation: 12,
              margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12).r,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildHeader(context, argNames.title, backgroundColor),
                    const BuildDivider(),
                    _buildContent(argNames.content, isDarkMode, context),
                  ],
                ),
              ),
            ),
          );
  }

  Widget _buildHeader(
      BuildContext context, String title, Color backgroundColor) {
    return CustomWidgetForDetailsHadithOrQuran(
      backgroundColor: backgroundColor,
      title: title,
      imageIcon: AssetsPath.assetsImagesHadithIcon,
    );
  }

  Widget _buildContent(
    String content,
    bool isDarkMode,
    BuildContext context,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
      alignment: Alignment.center,
      child: Text(
        content,
        textAlign: TextAlign.center,
        textDirection: TextDirection.rtl,
        style: TextStyle(
          fontSize: getResponsiveFontSize(context, fontSize: 25.sp),
          color: isDarkMode ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
