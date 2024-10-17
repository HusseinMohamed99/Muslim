part of '../../core/helpers/export_manager/export_manager.dart';

class HomeLayout extends StatefulWidget {
  static const String routeName = 'HomeLayout';

  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int _currentIndex = 2;
  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);

    return UpgradeWrapper(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(settingsProvider.getBackgroundImage()),
            fit: BoxFit.fill,
          ),
        ),
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              _appTitles(context)[_currentIndex],
              style: GoogleFonts.elMessiri(
                fontSize: getResponsiveFontSize(context, fontSize: 25.sp),
              ),
            ),
            leading: IconButton(
                onPressed: () {
                  navigateTo(context, routeName: SettingsScreen.routeName);
                },
                icon: const Icon(Icons.settings)),
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: _onItemTapped,
            currentIndex: _currentIndex,
            items: _buildBottomNavigationBarItems(context, _currentIndex),
          ),
          body: _screens[_currentIndex],
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  List<BottomNavigationBarItem> _buildBottomNavigationBarItems(
      BuildContext context, int index) {
    return [
      _buildBottomNavigationBarItem(
        icon: AssetsPath.assetsImagesHomeIcon,
        label: AppLocalizations.of(context)!.home,
      ),
      _buildBottomNavigationBarItem(
        icon: AssetsPath.assetsImagesHadithIcon,
        label: AppLocalizations.of(context)!.hadith,
      ),
      _buildBottomNavigationBarItem(
        icon: AssetsPath.assetsImagesQuranIcon,
        label: AppLocalizations.of(context)!.quran,
        index: 0,
      ),
      _buildBottomNavigationBarItem(
        icon: AssetsPath.assetsImagesSebhaIcon,
        label: AppLocalizations.of(context)!.sebha,
      ),
      _buildBottomNavigationBarItem(
        icon: AssetsPath.assetsImagesRadioIcon,
        label: AppLocalizations.of(context)!.radio,
      ),
    ];
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem({
    dynamic icon,
    required String label,
    int? index,
  }) {
    final isDarkMode = Provider.of<SettingsProvider>(context).isDarkMode();

    return BottomNavigationBarItem(
      backgroundColor: Theme.of(context).primaryColor,
      icon: index != 0
          ? ImageIcon(AssetImage(icon))
          : CircleAvatar(
              backgroundColor: isDarkMode
                  ? const Color(0xffFACC1D)
                  : const Color(0xff141A2E),
              child: Image(image: AssetImage(icon)),
            ),
      label: label,
    );
  }

  final List<Widget> _screens = [
    const HomeScreen(),
    const HadithScreen(),
    const QuranScreen(),
    const SebhaScreen(),
    const RadioScreen(),
  ];
}

List<String> _appTitles(context) => [
      AppLocalizations.of(context)!.home,
      AppLocalizations.of(context)!.hadith_name,
      AppLocalizations.of(context)!.quran_kareem,
      AppLocalizations.of(context)!.sebha,
      AppLocalizations.of(context)!.radio,
    ];
