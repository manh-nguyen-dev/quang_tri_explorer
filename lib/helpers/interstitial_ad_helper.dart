import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../utils/logger_util.dart';

class InterstitialAdHelper {
  static bool _isAdLoaded = false;
  static InterstitialAd? _interstitialAd;
  static Function? onAdClosed;

  static const String _adUnitId = "ca-app-pub-8240824237809528/5180275804";

  static void initialize() {
    MobileAds.instance.initialize();
  }

  static void loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: _adUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          _isAdLoaded = true;
          _setFullScreenContentCallback(ad);
        },
        onAdFailedToLoad: (LoadAdError loadAdError) {
          LoggerUtil.logError("Quảng cáo liên kết không tải được: $loadAdError");
          _isAdLoaded = false;
        },
      ),
    );
  }

  static void _setFullScreenContentCallback(InterstitialAd ad) {
    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) {
        LoggerUtil.logInfo("$ad đã hiển thị nội dung toàn màn hình");
      },
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        LoggerUtil.logInfo("Quảng cáo đã bị đóng");
        ad.dispose();
        _isAdLoaded = false;
        loadInterstitialAd();
        if (onAdClosed != null) {
          onAdClosed!();
        }
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        LoggerUtil.logError("Quảng cáo đã bị đóng");
        LoggerUtil.logError("Quảng cáo không thể hiển thị nội dung toàn màn hình: $error");
        _isAdLoaded = false;
      },
      onAdImpression: (InterstitialAd ad) {
        LoggerUtil.logInfo("Người dùng đã thấy $ad");
      },
    );
  }

  static void showInterstitialAd() {
    if (_isAdLoaded) {
      _interstitialAd?.show();
    } else {
      LoggerUtil.logInfo("Quảng cáo liên kết chưa được tải.");
      loadInterstitialAd();
    }
  }

  static void dispose() {
    _interstitialAd?.dispose();
    _isAdLoaded = false;
  }
}
