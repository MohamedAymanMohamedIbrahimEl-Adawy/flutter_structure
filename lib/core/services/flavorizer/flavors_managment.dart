import '../log/app_log.dart';
import 'flavor_model.dart';
import 'flavors.dart';

class FlavorsManagement {
  FlavorsManagement._privateConstructor();
  static final FlavorsManagement instance =
      FlavorsManagement._privateConstructor();

  late final Flavor flavor;

  final List<Flavor> availableFlavors = [
    DevelopmentFlavor(),
    StageFlavor(),
    ProductionFlavor(),
    EnterpriseFlavor(),
  ];

  FlavorModel getCurrentFlavor() {
    return flavor.getCurrentFlavor;
  }

  void init() {
    AppLog.printValue('Init Flavors Management');
    const String? flavorName =
        String.fromEnvironment('FLUTTER_APP_FLAVOR') != ''
            ? String.fromEnvironment('FLUTTER_APP_FLAVOR')
            : null;

    AppLog.printValueAndTitle('Flavor Name', flavorName);
    if (flavorName == null) {
      flavor = availableFlavors[3];
    } else {
      flavor = availableFlavors
          .firstWhere((e) => e.getCurrentFlavor.flavorType!.name == flavorName);
    }
    AppLog.printValue(flavor.getCurrentFlavor.toString());
  }
}
