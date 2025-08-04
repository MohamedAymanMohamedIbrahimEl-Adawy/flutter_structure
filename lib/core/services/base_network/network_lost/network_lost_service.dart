import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:cleanarchitecture/core/data/constants/app_router.dart';
import 'package:cleanarchitecture/core/data/constants/global_obj.dart';

class NetworkLostService {
  // Create a stream to listen for network changes
  StreamController<bool> networkStatusController = StreamController<bool>();

  NetworkLostService() {
    _initializeNetworkListener();
  }

  void _initializeNetworkListener() {
    // Listen to the connectivity changes
    Connectivity().onConnectivityChanged.listen((connectivityResult) {
      if (connectivityResult.contains(ConnectivityResult.mobile)) {
        // Mobile network available.
        final hasInternet = _hasInternet(ConnectivityResult.mobile);
        networkStatusController.add(hasInternet);
        removeNetworkLostScreen();
      } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
        // Wi-fi is available.
        // Note for Android:
        // When both mobile and Wi-Fi are turned on system will return Wi-Fi only as active network type
        final hasInternet = _hasInternet(ConnectivityResult.mobile);
        removeNetworkLostScreen();
        networkStatusController.add(hasInternet);
      } else if (connectivityResult.contains(ConnectivityResult.ethernet)) {
        // Ethernet connection available.
      } else if (connectivityResult.contains(ConnectivityResult.vpn)) {
        // Vpn connection active.
        // Note for iOS and macOS:
        // There is no separate network interface type for [vpn].
        // It returns [other] on any device (also simulator)
        final hasInternet = _hasInternet(ConnectivityResult.vpn);
        networkStatusController.add(hasInternet);
      } else if (connectivityResult.contains(ConnectivityResult.bluetooth)) {
        // Bluetooth connection available.
        final hasInternet = _hasInternet(ConnectivityResult.bluetooth);
        networkStatusController.add(hasInternet);
      } else if (connectivityResult.contains(ConnectivityResult.other)) {
        // Connected to a network which is not in the above mentioned networks.
        final hasInternet = _hasInternet(ConnectivityResult.other);
        networkStatusController.add(hasInternet);
      } else if (connectivityResult.contains(ConnectivityResult.none)) {
        // No available network types
        final hasInternet = _hasInternet(ConnectivityResult.none);
        networkStatusController.add(hasInternet);
        showNetworkLostScreen();
      }
    });
  }

  // Push the Network Lost screen on top of other screens
  Future<void> showNetworkLostScreen() async {
    // If the network lost screen isn't already pushed, navigate to it
    // print('herereeeeeeeShow');
    // routerManager().push(AppRouter.noInternet);
    // if (ModalRoute.of(navigatorKey.currentState!.context)?.settings.name != AppRouter.noInternet) {
    await Future.delayed(const Duration(seconds: 1));
    moveToNetworkScreen();
    // print('herereeeeeeeShow');
    // Navigator.pushNamed(navigatorKey.currentState!.context, AppRouter.noInternet);
    // }
  }

  // Remove the Network Lost screen if the network is back
  Future<void> removeNetworkLostScreen() async {
    // routerManager().pop();
    // routerManager()
    // print('herereeeeeeeRemove');
    if (ModalRoute.of(navigatorKey.currentState!.context)?.settings.name ==
        AppRouter.noInternet) {
      await Future.delayed(const Duration(seconds: 1));
      pop();
      // Navigator.pop(navigatorKey.currentState!.context);
    }
  }

  bool _hasInternet(ConnectivityResult result) {
    return result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi;
  }

  void moveToNetworkScreen() {
    navigatorKey.currentState!.context.pushNamed(AppRouter.noInternet);
  }

  void pop() {
    navigatorKey.currentState!.context.pop();
  }

  void dispose() {
    networkStatusController.close();
  }
}
