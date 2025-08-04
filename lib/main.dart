import 'package:cleanarchitecture/myapp.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'core/services/localization/app_localization.dart';
import 'di.dart';
import 'package:sizer/sizer.dart';

import 'core/services/notifications/notifications_services.dart';

bool isPickFile = false;

void main() async {
  // Init Flutter
  WidgetsFlutterBinding.ensureInitialized();

  // Run security checks
  // await runSecurityChecks();

  // Disable screenshot
  // await ScreenShotManager().disableScreenshot();

  await AppDependencies().initialize();

  // // Request Notifications permisson
  await NotificationsServices.instance.requestPermission();

  // Handle firebase background notifications
  FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);

  runApp(
    EasyLocalization(
      supportedLocales: AppLocalization.getSupportedLocales,
      fallbackLocale: AppLocalization.fallbackLocale,
      path: AppLocalization.getPath,
      startLocale: AppLocalization.startLocale,
      child: Sizer(
        builder: (p0, p1, p2) {
          return const MyApp();
        },
      ),
    ),
  );
}
