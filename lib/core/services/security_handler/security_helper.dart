import 'dart:async';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_security_checker/flutter_security_checker.dart';
import 'package:cleanarchitecture/core/global/enums/global_enum.dart';
import 'package:cleanarchitecture/core/services/flavorizer/flavors_managment.dart';

import '../log/app_log.dart';

const platform = MethodChannel('com.example.root_check');

Future<bool> isAppInstalled() async {
  bool isInstalled = false;
  if (Platform.isAndroid) {
    try {
      isInstalled = await platform.invokeMethod('isAppInstalled');
    } catch (e) {
      AppLog.logValue(e);
    }
  }
  return isInstalled;
}

Future<bool> doesWhichWork() async {
  bool isWhichWork = false;
  if (Platform.isAndroid) {
    try {
      isWhichWork = await platform.invokeMethod('doesWhichWork');
    } catch (e) {
      AppLog.logValue(e);
    }
  }
  return isWhichWork;
}

Future<bool> stopAppFunction() async {
  bool isStopApp = false;
  if (Platform.isAndroid) {
    try {
      isStopApp = await platform.invokeMethod('stopApp');
    } catch (e) {
      AppLog.logValue(e);
    }
  }
  return isStopApp;
  // if (isStopApp) {
  //   _closeApp();
  // }
}

Future<bool> checkDeviceStatus() async {
  bool rooted = false;
  if (Platform.isAndroid) {
    try {
      rooted = await platform.invokeMethod('isDeviceRooted');
    } catch (e) {
      AppLog.logValue(e);
    }
  }
  return rooted;
}

Future<bool> isFridaRunning() async {
  bool isFridaRunning = false;
  if (Platform.isAndroid) {
    try {
      isFridaRunning = await platform.invokeMethod('checkFrida') ?? false;
    } on PlatformException {
      return false;
    }
  }
  return isFridaRunning;
}

Future<bool> isAdbEnabled() async {
  bool isAdbEnabled = false;
  if (Platform.isAndroid) {
    try {
      isAdbEnabled = await platform.invokeMethod('isAdbEnabled') ?? false;
    } catch (e) {
      isAdbEnabled = false;
    }
  }
  return isAdbEnabled;
}

Future<bool> checkPhysicalDevice() async {
  final deviceInfoPlugin = DeviceInfoPlugin();
  final BaseDeviceInfo deviceInfo = await deviceInfoPlugin.deviceInfo;
  // final allInfo = deviceInfo.data;
  return (deviceInfo.data['isPhysicalDevice'] as bool);
}

Future<bool> isRootedDevice() async {
  final bool isRooted = await FlutterSecurityChecker.isRooted;
  return isRooted;
}

// Check whether the device on which the app is installed is a physical device.
Future<bool> isRealDevice() async {
  final bool isRealDevice = await FlutterSecurityChecker.isRealDevice;

  return isRealDevice;
}

Future<bool> checkDyldHooked() async {
  try {
    final bool isHooked = await platform.invokeMethod('isDyldHooked');
    return isHooked;
  } on PlatformException {
    return false;
  }
}

Future<bool> runSecurityChecks() async {
  if (FlavorsManagement.instance.getCurrentFlavor().flavorType !=
      FlavorsTypes.dev) {
    bool isInstalled = await isAppInstalled();
    bool isStopped = await stopAppFunction();
    bool doesWhich = await doesWhichWork();
    bool isCheck = await checkDeviceStatus();
    bool isEnabled = await isAdbEnabled();
    bool isFrida = await isFridaRunning();
    bool isRootedDev = await isRootedDevice();
    // bool isRooted = await checkIfRooted();
    bool isReal = await isRealDevice();
    bool isPhysical = await checkPhysicalDevice();

    if (isInstalled ||
        isStopped ||
        doesWhich ||
        // isRooted ||
        isCheck ||
        isEnabled ||
        isFrida ||
        isRootedDev ||
        !isReal ||
        !isPhysical ||
        kDebugMode) {
      _closeApp2();
      return true;
    } else {
      return false;
    }
  } else {
    return true;
  }
}

void _closeApp2() {
  if (Platform.isAndroid) {
    exit(0);
  } else if (Platform.isIOS) {
    exit(0);
  }
}
