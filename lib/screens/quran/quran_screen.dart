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
        const MyDivider(),
        _buildTitle(context, isDarkMode),
        _buildSuraList(context, isDarkMode, isArabic),
      ],
    );
  }

  Widget _buildHeaderImage() {
    return Expanded(
      flex: 2,
      child: Image.asset(AssetsPath.quranImage),
    );
  }

  Widget _buildTitle(BuildContext context, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.all(6.0).r,
      child: Text(
        AppLocalizations.of(context)!.sura_name,
        style: GoogleFonts.elMessiri(
          fontSize: 25.sp,
          fontWeight: FontWeight.w500,
          color: isDarkMode ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  Widget _buildSuraList(BuildContext context, bool isDarkMode, bool isArabic) {
    return Expanded(
      flex: 5,
      child: Stack(
        alignment: Alignment.center,
        children: [
          _buildSeparatorLine(isDarkMode),
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

  Widget _buildSeparatorLine(bool isDarkMode) {
    return Container(
      height: double.infinity,
      width: 3.0,
      color: isDarkMode ? ThemeApp.yellow : ThemeApp.lightPrimary,
    );
  }

  Widget _buildItemSeparator(bool isDarkMode) {
    return Container(
      width: double.infinity,
      height: 3.0.h,
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0).r,
        child: Container(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildText(names, isDarkMode),
              _buildText(numbers, isDarkMode),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildText(String text, bool isDarkMode) {
    return SizedBox(
      width: 100.w,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: GoogleFonts.elMessiri(
          fontSize: 20.sp,
          color: isDarkMode ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
