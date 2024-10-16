import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muslim_app/core/helpers/export_manager/export_manager.dart';
import 'package:muslim_app/shared/image_path/image_path.dart';
import 'package:muslim_app/shared/providers/settings_provider.dart';
import 'package:muslim_app/shared/style/theme.dart';
import 'package:provider/provider.dart';

class SebhaScreen extends StatefulWidget {
  static const String routeName = 'SebhaScreen';

  const SebhaScreen({super.key});

  @override
  State<SebhaScreen> createState() => _SebhaScreenState();
}

class _SebhaScreenState extends State<SebhaScreen> {
  int _indexCounter = 0;
  int _currentIndex = 0;
  final List<String> _azkar = [
    'أَسْـتَغْفِرُ الله',
    'اللّهُـمَّ أَنْـتَ السَّلامُ ، وَمِـنْكَ السَّلام ، تَبارَكْتَ يا ذا الجَـلالِ وَالإِكْـرام',
    'سُـبْحانَ اللهِ',
    'الحَمْـدُ لله',
    'اللهُ أكْـبَر',
    'لا إلهَ إلاّ اللّهُ وَحْـدَهُ لا شريكَ لهُ، لهُ الملكُ ولهُ الحَمْد، وهُوَ على كُلّ شَيءٍ قَـدير',
  ];
  double _angle = 2 * 3.14; // Initial angle = 360 degrees

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final locale = AppLocalizations.of(context)!;
    final appProvider = Provider.of<SettingsProvider>(context);
    final isDarkMode = appProvider.isDarkMode();

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildHeaderImage(appProvider, mediaQuery),
          SizedBox(height: mediaQuery.height / 20.23),
          _buildCounterText(appProvider),
          _buildAzkarButton(appProvider, locale),
          SizedBox(height: 10.h),
          TextButton(
            onPressed: _onAzkarButtonPressed,
            child: Text(
              AppLocalizations.of(context)!.reset,
              style: GoogleFonts.elMessiri(
                fontSize: getResponsiveFontSize(context, fontSize: 15.sp),
                fontWeight: FontWeight.w500,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderImage(SettingsProvider appProvider, Size mediaQuery) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          margin: EdgeInsets.only(left: 40.w),
          child: Image.asset(
            appProvider.isDarkMode()
                ? AssetsPath.assetsImagesSebhaHeadHeaderDark
                : AssetsPath.assetsImagesSebhaHeadHeader,
            width: mediaQuery.width / 5.64,
            height: mediaQuery.height / 8.285,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 72.h),
          child: Transform.rotate(
            angle: _angle,
            child: GestureDetector(
              onTap: _onRotateTap,
              child: Image.asset(
                appProvider.isDarkMode()
                    ? AssetsPath.assetsImagesSebhaHeadBodyDark
                    : AssetsPath.assetsImagesSebhaHeadBody,
                width: mediaQuery.width / 1.776,
                height: mediaQuery.height / 3.718,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCounterText(SettingsProvider appProvider) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).primaryColor,
      ),
      child: Text(
        _indexCounter.toString(),
        style: GoogleFonts.elMessiri(
          fontSize: getResponsiveFontSize(context, fontSize: 32.sp),
          fontWeight: FontWeight.bold,
          color: appProvider.isDarkMode() ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  Widget _buildAzkarButton(
      SettingsProvider appProvider, AppLocalizations locale) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: OutlinedButton(
        onPressed: _onRotateTap,
        style: OutlinedButton.styleFrom(
          backgroundColor: appProvider.isDarkMode()
              ? ThemeApp.yellow
              : ThemeApp.lightPrimary,
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.horizontal(
              right: Radius.circular(10),
              left: Radius.circular(10),
            ),
          ),
        ),
        child: Text(
          _azkar[_currentIndex],
          style: GoogleFonts.elMessiri(
            fontSize: getResponsiveFontSize(context, fontSize: 20.sp),
            fontWeight: FontWeight.bold,
            color: appProvider.isDarkMode() ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  void _onRotateTap() {
    setState(() {
      {
        if (_angle == 0 || _currentIndex == 0 && _indexCounter == 3) {
          _angle = 2 * 3.14;
          _indexCounter = 0;
          _currentIndex = _currentIndex + 1;
        } else if (_angle == 0 || _currentIndex == 1 && _indexCounter == 1) {
          _angle = 2 * 3.14;
          _indexCounter = 0;
          _currentIndex = _currentIndex + 1;
        } else if (_angle == 0 || _currentIndex == 5 && _indexCounter == 10) {
          _angle = 2 * 3.14;
          _indexCounter = 0;
          _currentIndex = (_currentIndex == 5) ? 0 : _currentIndex + 1;
        } else if (_angle == 0 || _indexCounter == 33) {
          _angle = 2 * 3.14;
          _indexCounter = 0;
          _currentIndex = _currentIndex + 1;
        }

        _angle -= (360 / 33) * (3.14 / 180); // Convert degrees to radians
        _indexCounter++;
      }
    });
  }

  void _onAzkarButtonPressed() {
    setState(() {
      _currentIndex = 0;
      _indexCounter = 0;
      _angle = 2 * 3.14; // Reset angle
    });
  }
}
