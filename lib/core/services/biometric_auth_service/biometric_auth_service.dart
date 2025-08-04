import 'package:flutter/material.dart';
import 'package:cleanarchitecture/core/services/local_storage/secure_storage/secure_storage_service.dart';
import 'package:local_auth/local_auth.dart';
import 'package:cleanarchitecture/core/services/log/app_log.dart';

class BiometricAuthService {
  final LocalAuthentication _auth = LocalAuthentication();

  // Check if the device supports biometric authentication
  Future<bool> isBiometricSupported() async {
    try {
      return await _auth.isDeviceSupported();
    } catch (e) {
      debugPrint("Error checking biometric support: $e");
      return false;
    }
  }

  // Check if biometrics are available
  Future<bool> canAuthenticateWithBiometrics() async {
    try {
      return await _auth.canCheckBiometrics;
    } catch (e) {
      debugPrint("Error checking biometric availability: $e");
      return false;
    }
  }

  /// Authenticate with biometrics
  Future<bool> authenticateWithBiometrics() async {
    try {
      return await _auth.authenticate(
        localizedReason: 'Scan your fingerprint or face to log in',
        options: const AuthenticationOptions(
          biometricOnly: true, // Only use biometrics
          stickyAuth: true, // Keeps session active across multiple attempts
        ),
      );
    } catch (e) {
      debugPrint("Biometric authentication error: $e");
      return false;
    }
  }

  Future<void> saveToken(String token) async {
    try {
      await SecureStorageService().write(key: 'auth_token', value: token);
    } catch (e) {
      debugPrint("Error saving token: $e");
    }
  }

  Future<String?> getToken() async {
    try {
      return await SecureStorageService().read(key: 'auth_token');
    } catch (e) {
      debugPrint("Error retrieving token: $e");
      return null;
    }
  }

  /// Handle the login process
  Future<bool> login(BuildContext context) async {
    final bool isSupported = await isBiometricSupported();
    final bool canAuthenticate = await canAuthenticateWithBiometrics();

    if (isSupported && canAuthenticate) {
      final bool isAuthenticated = await authenticateWithBiometrics();
      if (isAuthenticated) {
        AppLog.logValue("Biometric login successful");
        await saveToken('token');
        // Successful logged
        return true;
      } else {
        AppLog.logValue("Biometric authentication failed");
        _showFallbackDialog(context);
        return false;
      }
    } else {
      AppLog.logValue("Biometrics not supported or not enrolled");
      _showFallbackDialog(context);
      return false;
    }
  }

  /// Show a fallback dialog for alternative login methods
  void _showFallbackDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Biometric Login Failed"),
          content: const Text("Use your password to log in instead."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Redirect to password login screen
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}



// class BiometricAuthService {
//   final LocalAuthentication _localAuthentication = LocalAuthentication();
//   final WriteSecureStorageUseCase _writeSecureStorageUseCase =  WriteSecureStorageUseCase(getIt());
//   final ReadSecureStorageUseCase _readSecureStorageUseCase =  ReadSecureStorageUseCase(getIt());
//
//   Future<bool> checkBiometricSupport() async {
//     try {
//       // Check if device supports biometrics
//       bool canCheckBiometrics = await _localAuthentication.canCheckBiometrics;
//
//       // Get list of available biometric types
//       List<BiometricType> availableBiometrics =
//       await _localAuthentication.getAvailableBiometrics();
//
//       return canCheckBiometrics && availableBiometrics.isNotEmpty;
//     } catch (e) {
//    AppLog.printValue('Biometric check error: $e');
//       return false;
//     }
//   }
//
//   Future<bool> authenticateUser() async {
//     try {
//       bool isSupported = await checkBiometricSupport();
//       if (!isSupported) {
//         return false;
//       }
//
//       bool authenticated = await _localAuthentication.authenticate(
//         localizedReason: 'Please authenticate to access your account',
//         options: const AuthenticationOptions(
//           stickyAuth: true,
//           biometricOnly: true,
//         ),
//       );
//
//       if (authenticated) {
//         // Store authentication state
//         await _writeSecureStorageUseCase.execute(key:'is_authenticated', value:'true');
//         return true;
//       }
//       return false;
//     } catch (e) {
//    AppLog.printValueAndTitle('Authentication error: $e');
//       return false;
//     }
//   }
//
//   Future<void> saveCredentials(String username, String password) async {
//     // Securely store credentials
//     await _writeSecureStorageUseCase.execute(key:'username', value:username);
//     await _writeSecureStorageUseCase.execute(key: 'password', value: password);
//   }
//
//   Future<bool> checkSavedCredentials() async {
//     String? username = await _readSecureStorageUseCase.execute(key: 'username');
//     String? password = await _readSecureStorageUseCase.execute(key: 'password');
//     return username != null && password != null;
//   }
// }

