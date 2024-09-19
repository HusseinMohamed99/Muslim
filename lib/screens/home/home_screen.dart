import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muslim_app/screens/hadith/hadith_screen.dart';
import 'package:muslim_app/screens/quran/quran_screen.dart';
import 'package:muslim_app/screens/radio/radio_screen.dart';
import 'package:muslim_app/screens/sebha/sebha_screen.dart';
import 'package:muslim_app/screens/settings/settings_screen.dart';
import 'package:muslim_app/shared/image_path/image_path.dart';
import 'package:muslim_app/shared/providers/settings_provider.dart';
import 'package:provider/provider.dart';

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

    return Container(
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
            style: GoogleFonts.elMessiri(),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: _onItemTapped,
          currentIndex: _currentIndex,
          items: _buildBottomNavigationBarItems(context),
        ),
        body: _screens[_currentIndex],
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
