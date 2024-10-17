part of './../../core/helpers/export_manager/export_manager.dart';

class QuranScreen extends StatelessWidget {
  static const String routeName = 'QuranScreen';

  const QuranScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);
    final isDarkMode = settingsProvider.isDarkMode();
    final isArabic = settingsProvider.currentLanguage == 'ar';

    return Column(
      children: [
        _buildHeaderImage(),
        _buildItemSeparator(isDarkMode),
        _buildSuraNameAndNumber(context, isDarkMode),
        _buildSuraList(context, isDarkMode, isArabic),
      ],
    );
  }

  Widget _buildHeaderImage() {
    return Expanded(
      flex: 2,
      child: Image.asset(AssetsPath.assetsImagesQuran),
    );
  }

  Widget _buildSuraList(BuildContext context, bool isDarkMode, bool isArabic) {
    return Expanded(
      flex: 5,
      child: Stack(
        alignment: Alignment.center,
        children: [
          _buildSeparatorLine(isDarkMode: isDarkMode),
          ListView.separated(
            separatorBuilder: (context, index) => SuraTitle(
              names: isArabic
                  ? QuranDetails.namesArabic[index]
                  : QuranDetails.namesEnglish[index],
              numbers: isArabic
                  ? QuranDetails.numbersArabic[index]
                  : QuranDetails.numbersEnglish[index],
              index: index,
            ),
            itemCount: (isArabic
                    ? QuranDetails.namesArabic.length
                    : QuranDetails.namesEnglish.length) +
                1,
            itemBuilder: (context, index) => _buildItemSeparator(isDarkMode),
          ),
        ],
      ),
    );
  }

  Widget _buildSuraNameAndNumber(BuildContext context, bool isDarkMode) {
    return SizedBox(
      child: Stack(
        alignment: Alignment.center,
        children: [
          _buildSeparatorLine(isDarkMode: isDarkMode, height: 30.h),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 40.0.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.sura_name,
                  style: GoogleFonts.elMessiri(
                    fontSize: getResponsiveFontSize(context, fontSize: 15.sp),
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.sura_number,
                  style: GoogleFonts.elMessiri(
                    fontSize: getResponsiveFontSize(context, fontSize: 15.sp),
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSeparatorLine({required bool isDarkMode, double? height}) {
    return Container(
      height: height ?? double.infinity,
      width: 3.0.h,
      color: isDarkMode ? ThemeApp.yellow : ThemeApp.lightPrimary,
    );
  }

  Widget _buildItemSeparator(bool isDarkMode) {
    return Container(
      width: double.infinity,
      height: 1.0.h,
      color: isDarkMode ? ThemeApp.yellow : ThemeApp.lightPrimary,
    );
  }
}

class SuraTitle extends StatelessWidget {
  final String names, numbers;
  final int index;

  const SuraTitle({
    required this.names,
    required this.numbers,
    required this.index,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);
    final isDarkMode = settingsProvider.isDarkMode();

    return InkWell(
      onTap: () {
        navigateTo(
          context,
          routeName: SuraDetailsScreen.routeName,
          arguments: SuraDetailsArg(
            names: names,
            index: index,
          ),
        );
      },
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 40.0.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildText(names, isDarkMode, context),
            Padding(
              padding: EdgeInsetsDirectional.only(end: 40.w),
              child: _buildText(numbers, isDarkMode, context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildText(String text, bool isDarkMode, BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: GoogleFonts.elMessiri(
        fontSize: getResponsiveFontSize(context, fontSize: 20.sp),
        color: isDarkMode ? Colors.white : Colors.black,
      ),
    );
  }
}
