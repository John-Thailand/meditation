import 'package:meditation/models/managers/ad_manager.dart';
import 'package:meditation/models/managers/in_app_purchase_manager.dart';
import 'package:meditation/models/managers/sound_manager.dart';
import 'package:meditation/models/repositories/shared_prefs_repository.dart';
import 'package:meditation/view_models/main_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> globalProviders = [
  ...independentModels,
  ...dependentModels,
  ...viewModels,
];

List<SingleChildWidget> independentModels = [
  Provider<SharedPrefsRepository>(
    create: (context) => SharedPrefsRepository(),
  ),
  Provider<SoundManager>(
    create: (context) => SoundManager(),
  ),
  Provider<AdManager>(
    create: (context) => AdManager(),
  ),
  Provider<InAppPurchaseManager>(
    create: (context) => InAppPurchaseManager(),
  ),
];

List<SingleChildWidget> dependentModels = [];

List<SingleChildWidget> viewModels = [
  ChangeNotifierProvider(
    create: (context) => MainViewModel(
      sharedPrefsRepository: context.read<SharedPrefsRepository>(),
      soundManager: context.read<SoundManager>(),
      adManager: context.read<AdManager>(),
      inAppPurchaseManager: context.read<InAppPurchaseManager>(),
    ),
  ),
];
