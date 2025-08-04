import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:upgrader/upgrader.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/constants/extra_constants.dart';
import '../../data/constants/global_obj.dart';
import '../../data/constants/shared_preferences_constants.dart';
import '../../component/dialog/app_alerts.dart';
import '../local_storage/shared_preference/shared_preference_service.dart';
import '../log/app_log.dart';

class AppStoreHandler {
  static Future<bool> get isUpdateAvailable async {
    final Upgrader upgrader = Upgrader();
    await upgrader.initialize();
    return upgrader.isUpdateAvailable();
  }

  static void checkForUpdate() async {
    if (kDebugMode) {
      return;
    }

    if (Platform.isAndroid) {
      InAppUpdate.checkForUpdate().then((updateInfo) {
        AppLog.logValue(updateInfo.updateAvailability);

        if (updateInfo.updateAvailability ==
            UpdateAvailability.updateAvailable) {
          AppLog.logValue(updateInfo.immediateUpdateAllowed);
          AppLog.logValue(updateInfo.flexibleUpdateAllowed);
          AppAlerts.showAlertYesOrNo(
            context: Get.navigatorState!.context,
            title: 'anUpdateAvailable',
            actionButtonTitleYes: 'update',
            actionButtonTitleNo: 'later',
          ).then((value) {
            if (value == true) {
              //Perform flexible update
              InAppUpdate.startFlexibleUpdate().then((appUpdateResult) {
                if (appUpdateResult == AppUpdateResult.success) {
                  //App Update successful
                  InAppUpdate.completeFlexibleUpdate();
                }
              });
            }
          });
        }
      });
    } else if (Platform.isIOS) {
      final Upgrader upgrader = Upgrader();
      await upgrader.initialize();

      if (upgrader.isUpdateAvailable()) {
        AppAlerts.showAlertYesOrNo(
          context: Get.context!,
          title: 'anUpdateAvailable',
          actionButtonTitleYes: 'update',
          actionButtonTitleNo: 'later',
        ).then((value) {
          if (value == true) {
            openStore();
          }
        });
      }
    } else {
      //
    }
  }

  // static void shareApp({required String appName, BuildContext? context}) async {
  //   await ShareServices.share(
  //     title: appName,
  //     context: context,
  //   );
  // }

  static void openStore() {
    if (Platform.isAndroid || Platform.isIOS) {
      final url = Uri.parse(
        Platform.isAndroid
            ? ExtraConstants.googlePlayUrl
            : ExtraConstants.appStoreUrl,
      );
      launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    }
  }

  static void rateApp() async {
    String? dateFirstTimeOpen = SharedPreferenceService()
        .getString(SharPrefConstants.dateFirstTimeOpenKey);
    if (dateFirstTimeOpen.isEmpty) {
      await SharedPreferenceService().setString(
          SharPrefConstants.dateFirstTimeOpenKey,
          DateTime.now().toIso8601String());
    } else if (DateTime.parse(dateFirstTimeOpen)
        .add(const Duration(days: 30))
        .isBefore(DateTime.now())) {
      final InAppReview inAppReview = InAppReview.instance;
      inAppReview.isAvailable().then((value) {
        if (value) {
          inAppReview.requestReview();
        }
      });
    }
  }
}
