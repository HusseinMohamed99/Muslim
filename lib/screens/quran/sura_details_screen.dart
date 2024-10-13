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
            style: GoogleFonts.elMessiri(),
          ),
        ),
        body: _buildBody(context, settingsProvider, argNames),
      ),
    );
  }

  Widget _buildBody(BuildContext context, SettingsProvider settingsProvider,
      SuraDetailsArg argNames) {
    return verses.isEmpty
        ? const Center(child: AdaptiveIndicator())
        : SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Card(
              color: settingsProvider.isDarkMode()
                  ? Theme.of(context).primaryColor
                  : Colors.white,
              elevation: 12,
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 20).r,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12).r,
              ),
              child: Column(
                children: [
                  _buildHeader(context, settingsProvider, argNames),
                  Container(
                    width: double.infinity,
                    height: 3.0.h,
                    color: settingsProvider.isDarkMode()
                        ? ThemeApp.yellow
                        : ThemeApp.lightPrimary,
                  ),
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
    final language = settingsProvider.currentLanguage;
    final title =
        language == 'en' ? 'Sura ${argNames.names}' : 'سورة ${argNames.names}';

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Space(width: 20.w, height: 0),
        CircleAvatar(
          backgroundColor: isDarkMode ? Colors.white : Colors.black,
          radius: 15.r,
          child: Icon(
            FontAwesomeIcons.circlePlay,
            color: isDarkMode ? Colors.black : Colors.white,
          ),
        ),
        const SizedBox.shrink(),
        Expanded(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.elMessiri(
              fontSize: 25.sp,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
        ),
      ],
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
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12).r,
      alignment: Alignment.center,
      child: Text(
        '$content ${getVerseEndSymbol(index + 1)}',
        textAlign: TextAlign.center,
        textDirection: TextDirection.rtl,
        style: GoogleFonts.amiriQuran(
          fontSize: 25.sp,
          color: settingsProvider.isDarkMode() ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
