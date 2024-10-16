part of './../../core/helpers/export_manager/export_manager.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'HomeScreen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              AppLocalizations.of(context)!.app_title,
              style: GoogleFonts.elMessiri(
                fontSize: getResponsiveFontSize(context, fontSize: 30.sp),
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
        icon: 'assets/images/hadith_icon.png',
        label: AppLocalizations.of(context)!.hadith,
      ),
      _buildBottomNavigationBarItem(
        icon: 'assets/images/sebha_icon.png',
        label: AppLocalizations.of(context)!.sebha,
      ),
      _buildBottomNavigationBarItem(
        icon: AssetsPath.assetsImagesQuranIcon,
        label: AppLocalizations.of(context)!.quran,
        index: 0,
      ),
      _buildBottomNavigationBarItem(
        icon: 'assets/images/radio_icon.png',
        label: AppLocalizations.of(context)!.radio,
      ),
      _buildBottomNavigationBarItem(
        icon: 'assets/images/radio_icon.png',
        label: AppLocalizations.of(context)!.settings,
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
              backgroundImage: AssetImage(icon),
              backgroundColor: isDarkMode
                  ? const Color(0xffFACC1D)
                  : const Color(0xff141A2E),
            ),
      label: label,
    );
  }

  final List<Widget> _screens = [
    const HadithScreen(),
    const SebhaScreen(),
    const QuranScreen(),
    const RadioScreen(),
    const SettingsScreen(),
  ];
}
