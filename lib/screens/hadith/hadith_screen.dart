import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muslim_app/model/hadith_details.dart';
import 'package:muslim_app/screens/hadith/hadith_details_screen.dart';
import 'package:muslim_app/shared/components/my_divider.dart';
import 'package:muslim_app/shared/components/navigator.dart';
import 'package:muslim_app/shared/image_path/image_path.dart';
import 'package:muslim_app/shared/providers/settings_provider.dart';
import 'package:muslim_app/shared/style/theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HadithScreen extends StatefulWidget {
  static const String routeName = 'HadithScreen';
  const HadithScreen({Key? key}) : super(key: key);

  @override
  State<HadithScreen> createState() => _HadithScreenState();
}

class _HadithScreenState extends State<HadithScreen> {
  List<HadithDetailsArg> allHadithList = [];

  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsProvider>(context);
    if (allHadithList.isEmpty) loadHadithFile();

    return Column(
      children: [
        Expanded(
          flex: 2,
          child: Image.asset(
            AssetsPath.alBasmalaImage,
          ),
        ),
        const MyDivider(),
        Padding(
          padding: const EdgeInsets.all(6.0).r,
          child: Text(
            AppLocalizations.of(context)!.hadith_name,
            style: GoogleFonts.elMessiri(
              fontSize: 25.sp,
              fontWeight: FontWeight.w500,
              color:
                  settingsProvider.isDarkMode() ? Colors.white : Colors.black,
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: ListView.separated(
            separatorBuilder: (_, index) {
              return HadithTitle(allHadithList[index]);
            },
            itemCount: allHadithList.length + 1,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                width: double.infinity,
                height: 3.0,
                color: settingsProvider.isDarkMode()
                    ? ThemeApp.yellow
                    : ThemeApp.lightPrimary,
              );
            },
          ),
        )
      ],
    );
  }

  void loadHadithFile() async {
    var settingsProvider = Provider.of<SettingsProvider>(context);

    List<HadithDetailsArg> hadithList = [];
    String content = settingsProvider.currentLanguage == 'en'
        ? await rootBundle.loadString('assets/hadith_files/hadith_en.txt')
        : await rootBundle.loadString('assets/hadith_files/hadith_ar.txt');
    List<String> allHadithContent = content.split("#");
    for (int i = 0; i < allHadithContent.length; i++) {
      String singleHadith = allHadithContent[i].trim();
      int indexOfFirstLine = singleHadith.indexOf("\n");
      String title = singleHadith.substring(0, indexOfFirstLine);
      String content = singleHadith.substring(indexOfFirstLine + 1);
      HadithDetailsArg hadith = HadithDetailsArg(title, content);
      hadithList.add(hadith);
    }
    allHadithList = hadithList;
    setState(() {});
  }
}

class HadithTitle extends StatelessWidget {
  final HadithDetailsArg hadith;
  const HadithTitle(this.hadith, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsProvider>(context);
    return InkWell(
      onTap: () {
        navigateTo(context,
            routeName: HadithDetailsScreen.routeName, arguments: hadith);
      },
      child: Container(
        alignment: Alignment.center,
        child: Text(
          hadith.title,
          textAlign: TextAlign.center,
          style: GoogleFonts.elMessiri(
            fontSize: 25.sp,
            color: settingsProvider.isDarkMode() ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
