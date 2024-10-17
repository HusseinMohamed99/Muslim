part of './../../core/helpers/export_manager/export_manager.dart';

class SuraDetailsScreen extends StatefulWidget {
  const SuraDetailsScreen({super.key});
  static const String routeName = 'SuraDetailsScreen';

  @override
  State<SuraDetailsScreen> createState() => _SuraDetailsScreenState();
}

class _SuraDetailsScreenState extends State<SuraDetailsScreen> {
  List<String> verses = [];

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);
    final argNames =
        ModalRoute.of(context)?.settings.arguments as SuraDetailsArg;
    final bool isDarkMode = settingsProvider.isDarkMode();
    final Color cardColor =
        isDarkMode ? Theme.of(context).primaryColor : Colors.white;

    if (verses.isEmpty) {
      _readFile(argNames.index + 1);
    }

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
          isDarkMode,
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, SettingsProvider settingsProvider,
      SuraDetailsArg argNames, Color cardColor, bool isDarkMode) {
    return verses.isEmpty
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
              child: Column(
                children: [
                  _buildHeader(context, settingsProvider, argNames),
                  const BuildDivider(),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (_, index) => _buildVerseWidget(
                          verses[index], index, settingsProvider),
                      itemCount: verses.length,
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  Widget _buildHeader(BuildContext context, SettingsProvider settingsProvider,
      SuraDetailsArg argNames) {
    final isDarkMode = settingsProvider.isDarkMode();
    final Color backgroundColor = isDarkMode ? Colors.white : Colors.black;

    final language = settingsProvider.currentLanguage;
    final title =
        language == 'en' ? 'Sura ${argNames.names}' : 'سورة ${argNames.names}';

    return CustomWidgetForDetailsHadithOrQuran(
      backgroundColor: backgroundColor,
      title: title,
      imageIcon: AssetsPath.assetsImagesQuranIcon,
    );
  }

  void _readFile(int fileIndex) async {
    final fileContent =
        await rootBundle.loadString('assets/quran_files/$fileIndex.txt');
    final lines = fileContent.trim().split('\n');
    setState(() {
      verses = lines;
    });
  }

  Widget _buildVerseWidget(
      String content, int index, SettingsProvider settingsProvider) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
      alignment: Alignment.center,
      child: Text(
        '$content ${getVerseEndSymbol(index + 1)}',
        textAlign: TextAlign.center,
        textDirection: TextDirection.rtl,
        style: GoogleFonts.amiriQuran(
          fontSize: getResponsiveFontSize(context, fontSize: 25.sp),
          color: settingsProvider.isDarkMode() ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
