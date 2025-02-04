part of '../../core/helpers/export_manager/export_manager.dart';

class HomeLayout extends StatefulWidget {
  static const String routeName = 'HomeLayout';

  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkForUpdate(context);
    });
    try {
      AdManager.loadAdBanner(() {
        setState(() {});
      });
    } catch (e) {
      log('Error loading banner ad: $e');
    }
  }

  @override
  void dispose() {
    AdManager.disposeAdBanner();
    AdManager.disposeInterstitialAd();
    super.dispose();
  }

  int _currentIndex = 2;
  @override
  Widget build(BuildContext context) {
    final settingsProvider =
        Provider.of<SettingsProvider>(context, listen: false);

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
            _appTitles(context)[_currentIndex],
            style: GoogleFonts.elMessiri(
              fontSize: getResponsiveFontSize(context, fontSize: 25.sp),
            ),
          ),
          leading: IconButton(
              onPressed: () {
                if (AdManager.interstitialAd != null) {
                  AdManager.interstitialAd!.show();
                } else {
                  log('⚠️ Interstitial ad is not ready, loading a new one...');
                  AdManager.loadInterstitialAd();
                }

                navigateTo(context, routeName: SettingsScreen.routeName);
              },
              icon: const Icon(Icons.settings)),
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: _onItemTapped,
          currentIndex: _currentIndex,
          items: _buildBottomNavigationBarItems(context, _currentIndex),
        ),
        body: Column(
          children: [
            Expanded(
              child: _screens[_currentIndex],
            ),
            Visibility(
              visible: AdManager.bannerAd != null,
              child: SizedBox(
                height: AdManager.bannerAd!.size.height.toDouble(),
                width: AdManager.bannerAd!.size.width.toDouble(),
                child: AdWidget(ad: AdManager.bannerAd!),
              ),
            ),
          ],
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
Future<void> checkForUpdate(BuildContext context) async {
  final remoteConfig = FirebaseRemoteConfig.instance;

  // Set the Remote Config fetch settings
  await remoteConfig.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(seconds: 10),
    minimumFetchInterval: const Duration(hours: 1),
  ));

  try {
    // Fetch and activate the remote config
    await remoteConfig.fetchAndActivate();

    // Get the remote version from Remote Config
    final latestVersion = remoteConfig.getString('latest_version');

    // Log the latest version to check if it's fetched correctly
    log('Latest version fetched: $latestVersion');

    // Get the current app version
    final packageInfo = await PackageInfo.fromPlatform();
    final currentVersion = packageInfo.version;

    // Log the current version
    log('Current app version: $currentVersion');

    // Check if the app needs to be updated
    if (_isVersionOlder(currentVersion, latestVersion)) {
      await showUpdateDialog(context);
    }
  } catch (e) {
    log('Error fetching remote config: $e');
  }
}

bool _isVersionOlder(String remoteVersion, String currentVersion) {
  // Split the versions and parse each part as an integer
  List<int> remoteParts =
      remoteVersion.split('.').map((part) => int.tryParse(part) ?? 0).toList();
  List<int> currentParts =
      currentVersion.split('.').map((part) => int.tryParse(part) ?? 0).toList();

  for (int i = 0; i < remoteParts.length; i++) {
    if (remoteParts[i] > currentParts[i]) {
      return true; // Remote version is newer
    } else if (remoteParts[i] < currentParts[i]) {
      return false; // Current version is up-to-date
    }
  }
  return false; // Versions are the same
}

Future<void> showUpdateDialog(BuildContext context) async {
  // Ensure the dialog is shown after the frame is rendered
  WidgetsBinding.instance.addPostFrameCallback(
    (_) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'تحديث جديد متاح',
              style: GoogleFonts.elMessiri(
                fontSize: getResponsiveFontSize(context, fontSize: 20.sp),
                color: Colors.black,
              ),
            ),
            content: const Text(
                'يوجد إصدار جديد من التطبيق. يُفضل تحديث التطبيق للحصول على أحدث الميزات.'),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'لاحقًا',
                  style: GoogleFonts.elMessiri(
                    fontSize: getResponsiveFontSize(context, fontSize: 20.sp),
                    color: Colors.black,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text(
                  'تحديث الآن',
                  style: GoogleFonts.elMessiri(
                    fontSize: getResponsiveFontSize(context, fontSize: 20.sp),
                    color: Colors.black,
                  ),
                ),
                onPressed: () {
                  _launchURL(
                      'https://play.google.com/store/apps/details?id=$appPackageName');
                },
              ),
            ],
          );
        },
      );
    },
  );
}
