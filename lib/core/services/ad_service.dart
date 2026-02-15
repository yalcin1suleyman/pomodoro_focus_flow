import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdService {
  static final AdService _instance = AdService._internal();

  factory AdService() {
    return _instance;
  }

  AdService._internal();

  RewardedAd? _rewardedAd;
  int _numRewardedLoadAttempts = 0;
  final int maxFailedLoadAttempts = 3;

  // Test Ad Unit IDs
  final String _bannerAdUnitIdAndroid = 'ca-app-pub-3940256099942544/6300978111';
  final String _rewardedAdUnitIdAndroid = 'ca-app-pub-3940256099942544/5224354917';

  // For iOS (Test IDs)
  final String _bannerAdUnitIdIos = 'ca-app-pub-3940256099942544/2934735716';
  final String _rewardedAdUnitIdIos = 'ca-app-pub-3940256099942544/1712485313';

  Future<void> init() async {
    await MobileAds.instance.initialize();
    _loadRewardedAd();
  }

  String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return _bannerAdUnitIdAndroid;
    } else if (Platform.isIOS) {
      return _bannerAdUnitIdIos;
    }
    return '';
  }

  String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return _rewardedAdUnitIdAndroid;
    } else if (Platform.isIOS) {
      return _rewardedAdUnitIdIos;
    }
    return '';
  }

  // Banner Ad Logic
  BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) => debugPrint('Banner Ad loaded.'),
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
          debugPrint('Banner Ad failed to load: $error');
        },
      ),
    );
  }

  // Rewarded Ad Logic
  void _loadRewardedAd() {
    RewardedAd.load(
      adUnitId: rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          debugPrint('$ad loaded.');
          _rewardedAd = ad;
          _numRewardedLoadAttempts = 0;
        },
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint('RewardedAd failed to load: $error');
          _rewardedAd = null;
          _numRewardedLoadAttempts += 1;
          if (_numRewardedLoadAttempts < maxFailedLoadAttempts) {
            _loadRewardedAd();
          }
        },
      ),
    );
  }

  void showRewardedAd({required Function onRewardEarned, required Function onAdDismissed}) {
    if (_rewardedAd == null) {
      debugPrint('Warning: attempt to show rewarded ad before loaded.');
      // Try loading again for next time
      _loadRewardedAd();
      // If ad is not ready, we can choose to let the user proceed or show an error.
      // For better UX, we might let them proceed or show a message "Ad not ready".
      // Here, we'll just not do anything or maybe call dismissed so user isn't stuck?
      // Actually, safest is to tell user it's not ready. Or just grant reward if we want to be nice (dev choice).
      // Let's just log and return. User sees nothing.
      // Better: trigger callback to say "failed" so UI can handle it.
      // But for simplicity, we'll try to load and just return.
      // Update: Let's treat no ad as "User can proceed" if we want to be generous, 
      // or "Try again later" if strict.
      // Given the requirement "share button locked", let's be strict but safe.
      onAdDismissed(); // Dismissed without reward
      return;
    }

    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) =>
          debugPrint('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        debugPrint('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _loadRewardedAd(); // Load the next one
        onAdDismissed();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        debugPrint('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _loadRewardedAd();
        onAdDismissed(); // Treat as dismissed
      },
    );

    _rewardedAd!.setImmersiveMode(true);
    _rewardedAd!.show(
      onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
        debugPrint('$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
        onRewardEarned();
      },
    );
    _rewardedAd = null;
  }
}
