part of './../../core/helpers/export_manager/export_manager.dart';

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
        _buildHadithList(settingsProvider),
      ],
    );
  }

  Widget _buildHeaderImage() {
    return Expanded(
      flex: 2,
      child: Image.asset(AssetsPath.assetsImagesAlbasmala),
    );
  }

  Widget _buildHadithList(SettingsProvider settingsProvider) {
    return Expanded(
      flex: 7,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemCount: allHadithList.length,
        separatorBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 24.w),
            height: 1.0.h,
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
            fontSize: getResponsiveFontSize(context, fontSize: 20.sp),
            color: settingsProvider.isDarkMode() ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
