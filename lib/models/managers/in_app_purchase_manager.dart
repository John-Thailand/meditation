import 'dart:io';
import 'package:flutter/services.dart';
import 'package:meditation/utils/constants.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class InAppPurchaseManager {
  late Offerings offerings;

  bool isDeleteAd = false;
  bool isSubscribed = false;

  Future<void> initPlatformState() async {
    await Purchases.setDebugLogsEnabled(true);

    if (Platform.isAndroid) {
      await Purchases.setup("goog_pOlPyGSmnVaNYtRcNtXkRbKDqtw");
    } else if (Platform.isIOS) {
      // TODO API KEYをセット
      await Purchases.setup("public_ios_sdk_key");

      // OR: if building for Amazon, be sure to follow the installation instructions then:
      // await Purchases.setup("public_amazon_sdk_key", useAmazon: true);
    }

    offerings = await Purchases.getOfferings();
    print("offerings: $offerings");
  }

  Future<void> getPurchaserInfo() async {
    try {
      final purchaseInfo = await Purchases.getPurchaserInfo();
      updatePurchases(purchaseInfo);
    } on PlatformException catch (e) {
      print(PurchasesErrorHelper.getErrorCode(e).toString());
    }
  }

  Future<void> makePurchase(PurchaseMode purchaseMode) async {
    Package? package;
    switch (purchaseMode) {
      case PurchaseMode.DONATE:
        package = offerings.all["donation"]?.getPackage("donation");
        break;
      case PurchaseMode.DELETE_AD:
        package = offerings.all["delete_ad"]?.lifetime;
        break;
      case PurchaseMode.SUBSCRIPTION:
        package = offerings.all["monthly_subscription"]?.monthly;
        break;
    }

    if (package == null) return;

    try {
      final purchaseInfo = await Purchases.purchasePackage(package);
      if (purchaseMode != PurchaseMode.DONATE) updatePurchases(purchaseInfo);
    } on PlatformException catch (e) {
      final errorCode = PurchasesErrorHelper.getErrorCode(e);
      if (errorCode == PurchasesErrorCode.purchaseCancelledError) {
        print("User Cancelled");
      } else if (errorCode == PurchasesErrorCode.purchaseNotAllowedError) {
        print("Purchases not allowed on this device.");
      } else if (errorCode == PurchasesErrorCode.purchaseInvalidError) {
        print("Purchases invalid, check payment source");
      } else {
        print("Unknown Error");
      }
    }
  }

  Future<void> recoverPurchase() async {
    try {
      final purchaseInfo = await Purchases.restoreTransactions();
      updatePurchases(purchaseInfo);
    } on PlatformException catch (e) {
      final errorCode = PurchasesErrorHelper.getErrorCode(e);
      print("restoreError: ${errorCode.toString()}");
    }
  }

  void updatePurchases(PurchaserInfo purchaseInfo) {
    final entitlements = purchaseInfo.entitlements.all;

    if (entitlements.isEmpty) {
      isDeleteAd = false;
      isSubscribed = false;
      return;
    }

    if (!entitlements.containsKey("delete_ad")) {
      isDeleteAd = false;
    } else if (entitlements["delete_ad"]!.isActive) {
      isDeleteAd = true;
    } else {
      isDeleteAd = false;
    }

    if (!entitlements.containsKey("monthly_subscription")) {
      isSubscribed = false;
    } else if (entitlements["monthly_subscription"]!.isActive) {
      isSubscribed = true;
    } else {
      isSubscribed = false;
    }
  }
}
