import 'dart:io';

import 'package:screen_protector/screen_protector.dart';

class ScreenShotManager {
  Future<void> disableScreenshot() async {
    // this for android and ios
    await ScreenProtector.preventScreenshotOn();
  }

  Future<void> protectDataLeakage() async {
    if (Platform.isAndroid) {
      await ScreenProtector.protectDataLeakageOn();
    }
  }

  Future<void> enableScreenshot() async {
    // this for android and ios
    await ScreenProtector.preventScreenshotOff();
  }
}
