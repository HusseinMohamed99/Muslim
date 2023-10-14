import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muslim_app/shared/components/size_box.dart';
import 'package:muslim_app/shared/image_path/image_path.dart';
import 'package:muslim_app/shared/providers/settings_provider.dart';
import 'package:muslim_app/shared/style/theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SebhaScreen extends StatefulWidget {
  static const String routeName = 'SebhaScreen';

  const SebhaScreen({Key? key}) : super(key: key);

  @override
  State<SebhaScreen> createState() => _SebhaScreenState();
}

int sIndex = 0;
int index = 1;

class _SebhaScreenState extends State<SebhaScreen> {
  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsProvider>(context);

    return Center(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                AssetsPath.sebhaImage,
                color: settingsProvider.isDarkMode()
                    ? ThemeApp.yellow
                    : ThemeApp.lightPrimary,
              ),
              if (sIndex >= 1000)
                Positioned(
                  top: 170,
                  child: Text(
                    '$index',
                    style: GoogleFonts.elMessiri(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.bold,
                      color: settingsProvider.isDarkMode()
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
            ],
          ),
          Space(width: 0, height: 20.h),
          Text(
            AppLocalizations.of(context)!.sebha_numbers,
            style: GoogleFonts.elMessiri(
              fontSize: 25.sp,
              color:
                  settingsProvider.isDarkMode() ? Colors.white : Colors.black,
            ),
          ),
          Space(width: 0, height: 20.h),
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 70.w,
                height: 60.h,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10.0).r,
                ),
              ),
              Text(
                '$sIndex',
                style: GoogleFonts.elMessiri(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                  color: settingsProvider.isDarkMode()
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ],
          ),
          Space(width: 0, height: 20.h),
          InkWell(
            onTap: () {
              setState(() {
                if (sIndex >= 33) {
                  setState(() {
                    sIndex = 0;
                    index++;
                  });
                } else {
                  sIndex++;
                }
              });
            },
            child: Container(
              padding:
                  const EdgeInsets.only(right: 15, left: 15, top: 5, bottom: 5)
                      .r,
              decoration: BoxDecoration(
                color: settingsProvider.isDarkMode()
                    ? ThemeApp.yellow
                    : ThemeApp.lightPrimary,
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Text(
                AppLocalizations.of(context)!.subhan_allah,
                textAlign: TextAlign.center,
                style: GoogleFonts.elMessiri(
                  fontSize: 25.sp,
                  fontWeight: FontWeight.bold,
                  color: settingsProvider.isDarkMode()
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
