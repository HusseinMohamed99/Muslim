import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muslim_app/screens/hadith/hadith_screen.dart';
import 'package:muslim_app/screens/quran/quran_screen.dart';
import 'package:muslim_app/screens/radio/radio_screen.dart';
import 'package:muslim_app/screens/sebha/sebha_screen.dart';
import 'package:muslim_app/screens/settings/settings_screen.dart';
import 'package:muslim_app/shared/image_path/image_path.dart';
import 'package:muslim_app/shared/providers/settings_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'HomeScreen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

int currentIndex = 0;

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsProvider>(context);

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
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          currentIndex: currentIndex,
          items: [
            BottomNavigationBarItem(
                backgroundColor: Theme.of(context).primaryColor,
                icon: const ImageIcon(
                  AssetImage(AssetsPath.quranIcon),
                ),
                label: AppLocalizations.of(context)!.quran),
            BottomNavigationBarItem(
                backgroundColor: Theme.of(context).primaryColor,
                icon: const ImageIcon(AssetImage('assets/images/hadith_icon.png')),
                label: AppLocalizations.of(context)!.hadith,),
            BottomNavigationBarItem(
                backgroundColor: Theme.of(context).primaryColor,
                icon: const ImageIcon(AssetImage('assets/images/sebha_icon.png')),
                label: AppLocalizations.of(context)!.sebha,),
            BottomNavigationBarItem(
                backgroundColor: Theme.of(context).primaryColor,
                icon: const ImageIcon(AssetImage('assets/images/radio_icon.png')),
                label: AppLocalizations.of(context)!.radio,),
            BottomNavigationBarItem(
                backgroundColor: Theme.of(context).primaryColor,
                icon: const Icon(Icons.settings),
                label: AppLocalizations.of(context)!.settings,),
          ],
        ),
        body: screens[currentIndex],
      ),
    );
  }

  List<Widget> screens = [
    const QuranScreen(),
    const HadithScreen(),
    const SebhaScreen(),
    const RadioScreen(),
    const SettingsScreen(),
  ];

}
