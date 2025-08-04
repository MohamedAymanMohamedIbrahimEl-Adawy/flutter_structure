import 'package:cleanarchitecture/core/services/log/app_log.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart' as handler;

class LocationService {
  Location location = Location();
  bool _serviceEnabled = false;
  PermissionStatus? _permissionGranted;
  LocationData? _locationData;

  Future<LocationData?> getCurrentLocation() async {
    try {
      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          return null;
        }
      }

      AppLog.printValueAndTitle('Service Enabled Status', _serviceEnabled);

      _permissionGranted = await location.hasPermission();
      AppLog.printValueAndTitle(
        'Permission Granted Status',
        _permissionGranted,
      );

      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
      }

      if (_permissionGranted == PermissionStatus.deniedForever) {
        AppLog.printValueAndTitle(
          'Permission Denied Forever',
          _permissionGranted,
        );
        handler.openAppSettings();
        return null;
      }

      if (_permissionGranted == PermissionStatus.granted) {
        _locationData = await location.getLocation();
      }

      AppLog.printValueAndTitle('Location Data', _locationData);
      return _locationData;
    } catch (e) {
      // Suppress the error to prevent the toast message
      AppLog.printValueAndTitle('Location Error', e.toString());
      return null;
    }
  }
}
