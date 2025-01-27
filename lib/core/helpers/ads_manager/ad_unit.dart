class AdUnit {
  static bool isAdTest = true;
  static String homeBanner = isAdTest
      ? 'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-4479962845986675/2601039800';
  static String addOpen = isAdTest
      ? 'ca-app-pub-3940256099942544/9257395921'
      : 'ca-app-pub-4479962845986675/2471648493';

  static String interstitialAd = isAdTest
      ? 'ca-app-pub-3940256099942544/1033173712'
      : 'ca-app-pub-4479962845986675/2140476008';

  static String rewardedAd = isAdTest
      ? 'ca-app-pub-3940256099942544/5224354917'
      : 'ca-app-pub-4479962845986675/1841093100';
}
