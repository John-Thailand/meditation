import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdManager {
  BannerAd? bannerAd;
  InterstitialAd? interstitialAd;

  int maxFailedToAttempt = 3;
  int _numInterstitialLoadAttempt = 0;

  Future<void> initAdmob() {
    return MobileAds.instance.initialize();
  }

  void initBannerAd() {
    bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: bannerAdUnitId,
      listener: BannerAdListener(),
      request: AdRequest(),
    );
  }

  void initInterstitialAd() {
    InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          interstitialAd = ad;
          _numInterstitialLoadAttempt = 0;
        },
        onAdFailedToLoad: (LoadAdError error) {
          interstitialAd = null;
          _numInterstitialLoadAttempt++;
          if (_numInterstitialLoadAttempt <= maxFailedToAttempt)
            initInterstitialAd();
        },
      ),
    );
  }

  void loadBannerAd() {
    bannerAd?.load();
  }

  void loadInterstitialAd() {
    _showInterstitialAd();
  }

  void _showInterstitialAd() {
    if (interstitialAd == null) return;
    interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (InterstitialAd ad) {
      ad.dispose();
      initInterstitialAd();
    }, onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError adError) {
      ad.dispose();
      initInterstitialAd();
    });
    interstitialAd!.show();
    interstitialAd = null;
  }

  dispose() {
    bannerAd?.dispose();
    interstitialAd?.dispose();
  }

  static String get appId {
    if (Platform.isAndroid) {
      return "ca-app-pub-4446209605119315~7464356238";
    } else if (Platform.isIOS) {
      return "ca-app-pub-4446209605119315~4694545052";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-4446209605119315/9946871734";
    } else if (Platform.isIOS) {
      return "ca-app-pub-4446209605119315/6913691894";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-4446209605119315/1162494150";
    } else if (Platform.isIOS) {
      return "ca-app-pub-4446209605119315/7516327129";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return "<YOUR_ANDROID_REWARDED_AD_UNIT_ID>";
    } else if (Platform.isIOS) {
      return "<YOUR_IOS_REWARDED_AD_UNIT_ID>";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
}
