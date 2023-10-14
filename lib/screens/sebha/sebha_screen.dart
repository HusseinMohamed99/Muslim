import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
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

class _SebhaScreenState extends State<SebhaScreen> {
  int indexCounter = 0;
  int currentIndex = 0;
  List<String> azkar = ['سبحان الله', 'الحمد لله', 'الله اكبر'];
  double _angle = 2 * 3.14; // angel = 360 degree <initial value>

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var locale = AppLocalizations.of(context)!;
    var theme = Theme.of(context);
    var appProvider = Provider.of<SettingsProvider>(context);
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 40),
                child: Image.asset(
                  appProvider.isDarkMode()
                      ? AssetsPath.sebhaHeaderDarkImage
                      : AssetsPath.sebhaHeaderImage,
                  width: mediaQuery.width / 5.64,
                  height: mediaQuery.height / 8.285,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 72),
                child: Transform.rotate(
                  angle: _angle,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (_angle == 0 || indexCounter == 33) {
                          _angle = 2 * 3.14;
                          indexCounter = 0;
                          (currentIndex == 2)
                              ? currentIndex = 0
                              : currentIndex++;
                        }

                        _angle -= (360 / 33) * (3.16 / 180);
                        indexCounter++;
                      });
                    },
                    child: Image.asset(
                      appProvider.isDarkMode()
                          ? AssetsPath.sebhaBodyDarkImage
                          : AssetsPath.sebhaBodyImage,
                      width: mediaQuery.width / 1.776,
                      height: mediaQuery.height / 3.718,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: mediaQuery.height / 20.23),
          Text(
            locale.sebha_numbers,
            style: GoogleFonts.elMessiri(
              fontSize: 25.sp,
              color: appProvider.isDarkMode() ? Colors.white : Colors.black,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.all(20),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: theme.primaryColor,
            ),
            child: Text(
              indexCounter.toString(),
              style: GoogleFonts.elMessiri(
                fontSize: 32.sp,
                fontWeight: FontWeight.bold,
                color: appProvider.isDarkMode() ? Colors.white : Colors.black,
              ),
            ),
          ),
          OutlinedButton(
            onPressed: () {
              if (currentIndex == 2) {
                currentIndex = 0;
              } else {
                currentIndex++;
              }
              setState(() {
                indexCounter = 0;
                _angle = 2 * 3.14;
              });
            },
            style: OutlinedButton.styleFrom(
              backgroundColor: appProvider.isDarkMode()
                  ? ThemeApp.yellow
                  : ThemeApp.lightPrimary,
              padding:
                  const EdgeInsets.only(right: 15, left: 15, top: 5, bottom: 5),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.horizontal(
                  right: Radius.circular(10),
                  left: Radius.circular(10),
                ),
              ),
            ),
            child: Text(
              azkar[currentIndex],
              style: GoogleFonts.elMessiri(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: appProvider.isDarkMode() ? Colors.white : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
