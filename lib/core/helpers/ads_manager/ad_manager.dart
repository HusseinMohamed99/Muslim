import 'dart:developer';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:muslim_app/core/helpers/ads_manager/ad_unit.dart';

class AdManager {
  static BannerAd? bannerAd;
  static AppOpenAd? appOpenAd;
  static InterstitialAd? interstitialAd;
  static RewardedAd? rewardedAd;
  static bool isShowingAd = false;

  static void loadAdBanner(void Function() setState) {
    bannerAd?.dispose(); // Dispose of the previous banner
    bannerAd = BannerAd(
      size: AdSize.fullBanner,
      adUnitId: AdUnit.homeBanner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          log('Banner Ad Loaded');
          setState();
        },
        onAdFailedToLoad: (ad, error) {
          log('Banner Ad failed to load: $error');
          ad.dispose();
          bannerAd = null;
        },
      ),
      request: const AdRequest(),
    )..load();
  }

  static void loadAdOpen() {
    // Dispose previous ad if exists
    if (appOpenAd != null) {
      appOpenAd!.dispose();
      appOpenAd = null;
    }

    log('🔄 Loading App Open Ad...');

    AppOpenAd.load(
      adUnitId: AdUnit.addOpen,
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdFailedToLoad: (LoadAdError error) {
          log('❌ App Open Ad failed to load: $error');
          appOpenAd = null;

          // Retry loading after a delay (avoid infinite loop)
          Future.delayed(const Duration(seconds: 5), loadAdOpen);
        },
        onAdLoaded: (AppOpenAd ad) {
          log('✅ App Open Ad successfully loaded');
          appOpenAd = ad;

          appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              log('🔄 App Open Ad dismissed, loading a new one...');
              ad.dispose();
              appOpenAd = null;

              // Delay the next load to avoid instant looping
              Future.delayed(const Duration(seconds: 5), loadAdOpen);
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              log('❌ App Open Ad failed to show: $error');
              ad.dispose();
              appOpenAd = null;

              // Retry after a delay
              Future.delayed(const Duration(seconds: 5), loadAdOpen);
            },
          );

          // Ensure the ad is **ready** before showing
          if (appOpenAd != null) {
            log('🚀 Showing App Open Ad...');
            appOpenAd!.show();
          }
        },
      ),
    );
  }

  static void loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdUnit.interstitialAd, // Ensure this is a valid ad unit ID
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdFailedToLoad: (LoadAdError error) {
          log('❌ Interstitial ad failed to load: $error');
          interstitialAd = null;

          // Optional: Retry loading after a delay
          Future.delayed(const Duration(seconds: 5), loadInterstitialAd);
        },
        onAdLoaded: (InterstitialAd ad) {
          log('✅ Interstitial ad successfully loaded');
          interstitialAd = ad;

          interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              log('🔄 Interstitial ad dismissed');
              ad.dispose();
              interstitialAd = null;
              loadInterstitialAd(); // Reload after closing
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              log('❌ Interstitial ad failed to show: $error');
              ad.dispose();
              interstitialAd = null;
              loadInterstitialAd();
            },
          );
        },
      ),
    );
  }

  static void loadRewardedAd(void Function() setState) {
    rewardedAd?.dispose();
    rewardedAd = null;

    RewardedAd.load(
      adUnitId: AdUnit.rewardedAd,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          log('Rewarded ad loaded');
          rewardedAd = ad;

          rewardedAd?.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              rewardedAd = null;
              log('Rewarded ad dismissed');
              isShowingAd = false;
              setState();
              loadRewardedAd(setState);
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              ad.dispose();
              rewardedAd = null;
              log('Rewarded ad failed to show: $error');
              loadRewardedAd(setState);
            },
          );
        },
        onAdFailedToLoad: (LoadAdError error) {
          log('Rewarded ad failed to load: $error');
          rewardedAd = null;
        },
      ),
    );
  }

  static void showRewardedAd(void Function() setState) {
    if (rewardedAd != null) {
      rewardedAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
          log('User earned reward: ${reward.amount} ${reward.type}');
          isShowingAd = true;
          setState();
        },
      );
    } else {
      log('No rewarded ad available, loading a new one...');
      loadRewardedAd(setState);
    }
  }

  static void disposeAdBanner() {
    bannerAd?.dispose();
    bannerAd = null;
  }

  static void disposeInterstitialAd() {
    interstitialAd?.dispose();
    interstitialAd = null;
  }

  static void disposeRewardedAd() {
    rewardedAd?.dispose();
    rewardedAd = null;
  }
}
