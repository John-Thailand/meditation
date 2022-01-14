import 'package:flutter/material.dart';
import 'package:meditation/data_models/user_settings.dart';
import 'package:meditation/models/managers/ad_manager.dart';
import 'package:meditation/models/managers/in_app_purchase_manager.dart';
import 'package:meditation/models/managers/sound_manager.dart';
import 'package:meditation/models/repositories/shared_prefs_repository.dart';
import 'package:meditation/utils/constants.dart';
import 'package:meditation/utils/functions.dart';

class MainViewModel extends ChangeNotifier {
  final SharedPrefsRepository sharedPrefsRepository;
  final SoundManager soundManager;
  final AdManager adManager;
  final InAppPurchaseManager inAppPurchaseManager;

  UserSettings? userSettings;

  RunningStatus runningStatus = RunningStatus.BEFORE_START;

  int remainingTimeSeconds = 0;
  String get remainingTimeString => convertTimeFormat(remainingTimeSeconds);

  MainViewModel(
      {required this.sharedPrefsRepository,
      required this.soundManager,
      required this.adManager,
      required this.inAppPurchaseManager});

  Future<void> skipIntro() async {
    await sharedPrefsRepository.skipIntro();
  }

  Future<bool> isSkipIntroScreen() async {
    return await sharedPrefsRepository.isSkipIntroScreen();
  }

  Future<void> getUserSettings() async {
    userSettings = await sharedPrefsRepository.getUserSettings();
    remainingTimeSeconds = userSettings!.timeMinutes * 60;
    notifyListeners();
  }

  Future<void> setLevel(int index) async {
    await sharedPrefsRepository.setLevel(index);
    getUserSettings();
  }

  Future<void> setTime(int timeMinutes) async {
    await sharedPrefsRepository.setTime(timeMinutes);
    getUserSettings();
  }

  Future<void> setTheme(int index) async {
    await sharedPrefsRepository.setTheme(index);
    getUserSettings();
  }
}
