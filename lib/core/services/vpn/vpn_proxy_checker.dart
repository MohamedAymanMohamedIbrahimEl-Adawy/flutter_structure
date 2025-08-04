import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VpnProxyChecker {
  static const MethodChannel _channel = MethodChannel('vpn_proxy_channel');

  /// Detects VPN using network interfaces (Android only)
  static Future<bool> isUsingVPN() async {
    try {
      final result = await _channel.invokeMethod<bool>('isUsingVPN');
      return result ?? false;
    } catch (_) {
      return false;
    }
  }

  /// Detects proxy settings on the device
  static Future<bool> isUsingProxy() async {
    try {
      final result = await _channel.invokeMethod<bool>('isUsingProxy');
      return result ?? false;
    } catch (_) {
      return false;
    }
  }

  static Future<bool> isUsingVPNOrProxy() async {
    final vpn = await isUsingVPN();
    final proxy = await isUsingProxy();
    return vpn || proxy;
  }
}

final vpnGuardProvider = FutureProvider<bool>((ref) async {
  final isVpnActive = await VpnProxyChecker.isUsingVPNOrProxy();
  return isVpnActive;
});
