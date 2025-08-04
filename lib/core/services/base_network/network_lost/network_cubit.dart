import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cleanarchitecture/core/services/flavorizer/flavors_managment.dart';

import '../../../component/custom_toast/p_toast.dart';
import '../../../global/enums/global_enum.dart';
import '../../log/app_log.dart';

enum NetworkStatus { initial, online, offline }

class NetworkCubit extends Cubit<NetworkStatus> {
  final Connectivity _connectivity;

  NetworkCubit(this._connectivity) : super(NetworkStatus.initial) {
    _connectivity.onConnectivityChanged.listen((event) {
      _updateStatus(event.first);
    });
    _checkInitialStatus();
  }

  void _checkInitialStatus() async {
    final result = await _connectivity.checkConnectivity();
    _updateStatus(result.first);
  }

  void _updateStatus(ConnectivityResult result) {
    if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      AppLog.printValueAndTitle('network Status', 'online');
      SafeToast.show(message: 'You Are Online !', type: MessageType.success);
      emit(NetworkStatus.online);
    } else {
      AppLog.printValueAndTitle('network Status', "offline");
      SafeToast.show(message: 'You Are Offline !', type: MessageType.error);
      emit(NetworkStatus.offline);
    }
  }

  Future<bool> canConnectToServer() async {
    try {
      final response = await Dio().get(
        FlavorsManagement.instance.flavor.getCurrentFlavor.baseUrl ?? '',
      ); // You can use Dio or any HTTP client for this
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      return false;
    }
  }
}
