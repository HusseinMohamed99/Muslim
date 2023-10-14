import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muslim_app/model/sura_details.dart';
import 'package:muslim_app/shared/adaptive/indicator.dart';
import 'package:muslim_app/shared/components/get_verses.dart';
import 'package:muslim_app/shared/components/indicator.dart';
import 'package:muslim_app/shared/components/size_box.dart';
import 'package:muslim_app/shared/providers/settings_provider.dart';
import 'package:muslim_app/shared/style/theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SuraDetailsScreen extends StatefulWidget {
  const SuraDetailsScreen({Key? key}) : super(key: key);
  static const String routeName = 'SuraDetailsScreen';

  @override
  State<SuraDetailsScreen> createState() => _SuraDetailsScreenState();
}

class _SuraDetailsScreenState extends State<SuraDetailsScreen> {
  List<String> verses = [];

  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsProvider>(context);

    SuraDetailsArg argNames =
        (ModalRoute.of(context)?.settings.arguments) as SuraDetailsArg;

    if (verses.isEmpty) {
      reaFile(argNames.index + 1);
    }
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            settingsProvider.getBackgroundImage(),
          ),
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
        body: verses.isEmpty
            ? Center(
                child: AdaptiveIndicator(
                  os: getOs(),
                ),
              )
            : SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Card(
                  color: settingsProvider.isDarkMode()
                      ? Theme.of(context).primaryColor
                      : Colors.white,
                  elevation: 12,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 64)
                          .r,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12).r,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                              backgroundColor: settingsProvider.isDarkMode()
                                  ? Colors.white
                                  : Colors.black,
                              radius: 15.r,
                              child: Icon(
                                FontAwesomeIcons.circlePlay,
                                color: settingsProvider.isDarkMode()
                                    ? Colors.black
                                    : Colors.white,
                              )),
                          Space(width: 20.w, height: 0),
                          Text(
                            settingsProvider.currentLanguage == 'en'
                                ? 'Sura ${argNames.names}'
                                : 'سورة ${argNames.names}',
                            style: GoogleFonts.elMessiri(
                              fontSize: 32.sp,
                              color: settingsProvider.isDarkMode()
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: double.infinity,
                        height: 3.0.h,
                        color: settingsProvider.isDarkMode()
                            ? ThemeApp.yellow
                            : ThemeApp.lightPrimary,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemBuilder: (_, index) {
                            return versesWidget(verses[index], index);
                          },
                          itemCount: verses.length,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  void reaFile(int fileIndex) async {
    String fileContent =
        await rootBundle.loadString('assets/quran_files/$fileIndex.txt');
    List<String> lines = fileContent.trim().split('\n');
    setState(() {
      verses = lines;
    });
  }

  Widget versesWidget(
    String content,
    int index,
  ) {
    var settingsProvider = Provider.of<SettingsProvider>(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12).r,
      alignment: Alignment.center,
      child: Text(
        '$content ${getVerseEndSymbol(index)}',
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
