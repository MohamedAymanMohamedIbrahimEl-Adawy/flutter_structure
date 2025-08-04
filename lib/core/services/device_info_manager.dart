import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:cleanarchitecture/core/extensions/string_extensions.dart';

import 'log/app_log.dart';
// import 'package:platform_device_id/platform_device_id.dart';

class DeviceInfoManager {
  static final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();

  /// Fetches the device name and ID, then returns them concatenated.
  static Future<String> getDeviceIdentity() async {
    String deviceName = await getDeviceName();
    String deviceId = await getDeviceId();
    // String? deviceId = await PlatformDeviceId.getDeviceId;

    // return "$deviceName - $deviceId";
    return "$deviceName - $deviceId";
  }

  /// Retrieves the device name based on platform.
  static Future<String> getDeviceName() async {
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await _deviceInfoPlugin.androidInfo;
      return androidInfo.model; // Example: "Samsung Galaxy S21"
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await _deviceInfoPlugin.iosInfo;
      AppLog.logValue(iosInfo);
      return !iosInfo.modelName.isEmptyOrNull
          ? iosInfo.modelName
          : iosInfo.utsname.machine; // Example: "iPhone14,2"
    }
    return "Unknown Device";
  }

  static Future<String> getDeviceId() async {
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await _deviceInfoPlugin.androidInfo;
      return androidInfo.id;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await _deviceInfoPlugin.iosInfo;
      return iosInfo.identifierForVendor ?? '';
    }
    return "Unknown Device";
  }
}
