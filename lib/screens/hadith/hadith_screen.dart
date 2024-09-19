import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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

class HadithScreen extends StatefulWidget {
  static const String routeName = 'HadithScreen';
  const HadithScreen({super.key});

  @override
  State<HadithScreen> createState() => _HadithScreenState();
}

class _HadithScreenState extends State<HadithScreen> {
  List<HadithDetailsArg> allHadithList = [];

  @override
  void initState() {
    super.initState();
    loadHadithFile();
  }

  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsProvider>(context);
    return Column(
      children: [
        _buildHeaderImage(),
        const MyDivider(),
        _buildTitle(context, settingsProvider),
        _buildHadithList(settingsProvider),
      ],
    );
  }

  Widget _buildHeaderImage() {
    return Expanded(
      flex: 2,
      child: Image.asset(AssetsPath.alBasmalaImage),
    );
  }

  Widget _buildTitle(BuildContext context, SettingsProvider settingsProvider) {
    return Padding(
      padding: const EdgeInsets.all(6.0).r,
      child: Text(
        AppLocalizations.of(context)!.hadith_name,
        style: GoogleFonts.elMessiri(
          fontSize: 25.sp,
          fontWeight: FontWeight.w500,
          color: settingsProvider.isDarkMode() ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  Widget _buildHadithList(SettingsProvider settingsProvider) {
    return Expanded(
      flex: 5,
      child: ListView.separated(
        itemCount: allHadithList.length,
        separatorBuilder: (context, index) {
          return Container(
            width: double.infinity,
            height: 3.0,
            color: settingsProvider.isDarkMode()
                ? ThemeApp.yellow
                : ThemeApp.lightPrimary,
          );
        },
        itemBuilder: (BuildContext context, int index) {
          return HadithTitle(hadith: allHadithList[index]);
        },
      ),
    );
  }

  Future<void> loadHadithFile() async {
    if (!mounted) return; // Ensure widget is mounted before accessing context
    var settingsProvider =
        Provider.of<SettingsProvider>(context, listen: false);

    String filePath = settingsProvider.currentLanguage == 'en'
        ? 'assets/hadith_files/hadith_en.txt'
        : 'assets/hadith_files/hadith_ar.txt';
    String content = await rootBundle.loadString(filePath);

    List<HadithDetailsArg> hadithList = content.split('#').map((hadithText) {
      final hadithLines = hadithText.trim().split('\n');
      return HadithDetailsArg(
          hadithLines.first, hadithLines.skip(1).join('\n'));
    }).toList();

    setState(() {
      allHadithList = hadithList;
    });
  }
}

class HadithTitle extends StatelessWidget {
  final HadithDetailsArg hadith;

  const HadithTitle({required this.hadith, super.key});

  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsProvider>(context);
    return InkWell(
      onTap: () {
        navigateTo(
          context,
          routeName: HadithDetailsScreen.routeName,
          arguments: hadith,
        );
      },
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 8.0.h),
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
