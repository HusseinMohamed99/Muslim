part of './../../core/helpers/export_manager/export_manager.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'HomeScreen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

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
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: _onItemTapped,
            currentIndex: _currentIndex,
            items: _buildBottomNavigationBarItems(context),
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
      BuildContext context) {
    return [
      _buildBottomNavigationBarItem(
        icon: AssetsPath.quranIcon,
        label: AppLocalizations.of(context)!.quran,
      ),
      _buildBottomNavigationBarItem(
        icon: 'assets/images/hadith_icon.png',
        label: AppLocalizations.of(context)!.hadith,
      ),
      _buildBottomNavigationBarItem(
        icon: 'assets/images/sebha_icon.png',
        label: AppLocalizations.of(context)!.sebha,
      ),
      _buildBottomNavigationBarItem(
        icon: 'assets/images/radio_icon.png',
        label: AppLocalizations.of(context)!.radio,
      ),
      _buildBottomNavigationBarItem(
        icon: Icons.settings,
        label: AppLocalizations.of(context)!.settings,
      ),
    ];
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem({
    required dynamic icon,
    required String label,
  }) {
    return BottomNavigationBarItem(
      backgroundColor: Theme.of(context).primaryColor,
      icon: icon is String ? ImageIcon(AssetImage(icon)) : Icon(icon),
      label: label,
    );
  }

  final List<Widget> _screens = [
    const QuranScreen(),
    const HadithScreen(),
    const SebhaScreen(),
    const RadioScreen(),
    const SettingsScreen(),
  ];
}

class UpgradeWrapper extends StatelessWidget {
  const UpgradeWrapper({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return UpgradeAlert(
      dialogStyle: Platform.isIOS
          ? UpgradeDialogStyle.cupertino
          : UpgradeDialogStyle.material,
      upgrader: Upgrader(),
      child: child,
    );
  }
}
