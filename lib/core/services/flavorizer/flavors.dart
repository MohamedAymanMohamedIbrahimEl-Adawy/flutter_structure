import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:cleanarchitecture/core/global/enums/global_enum.dart';
import 'flavor_model.dart';

abstract class Flavor {
  FlavorModel get getCurrentFlavor;
}

class DevelopmentFlavor extends Flavor {
  @override
  FlavorModel get getCurrentFlavor =>
      FlavorModel()
        ..title = 'Development App'
        ..baseUrl = dotenv.env['BASE_URL_DEV']
        ..description = 'Development Flavor Egypt'
        ..androidBundleId = 'com.flutter.structure.dev'
        ..iosBundleId = 'com.flutter.structure.dev'
        ..flavorType = FlavorsTypes.dev;
}

class StageFlavor extends Flavor {
  @override
  FlavorModel get getCurrentFlavor =>
      FlavorModel()
        ..title = 'Stage App'
        ..baseUrl = dotenv.env['BASE_URL_STAGE']
        ..description = 'Stage Flavor Egypt'
        ..androidBundleId = 'com.flutter.structure.stage'
        ..iosBundleId = 'com.flutter.structure.stage'
        ..flavorType = FlavorsTypes.stage;
}

class ProductionFlavor extends Flavor {
  @override
  FlavorModel get getCurrentFlavor =>
      FlavorModel()
        ..title = 'Production App'
        ..baseUrl = dotenv.env['BASE_URL_PROD']
        ..description = 'Production Flavor'
        ..androidBundleId = 'com.flutter.structure'
        ..iosBundleId = 'com.flutter.structure'
        ..flavorType = FlavorsTypes.prod;
}

class EnterpriseFlavor extends Flavor {
  @override
  FlavorModel get getCurrentFlavor =>
      FlavorModel()
        ..title = 'Enterprise App'
        ..baseUrl = dotenv.env['BASE_URL_ENTER']
        ..description = 'Enterprise Flavor'
        ..androidBundleId = 'com.flutter.structure.enterprise'
        ..iosBundleId = 'com.flutter.structure.enterprise'
        ..flavorType = FlavorsTypes.enterprise;
}
