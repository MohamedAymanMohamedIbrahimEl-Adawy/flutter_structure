import 'dart:io';
import 'package:cleanarchitecture/core/services/base_network/client/dio_client.dart';
import 'package:cleanarchitecture/core/services/base_network/network_lost/network_info.dart';
import 'package:cleanarchitecture/core/data/constants/shared_preferences_constants.dart';
import 'package:cleanarchitecture/core/services/local_storage/secure_storage/secure_storage_service.dart';

class MainRepository {
  final DioClient remoteData;
  // final LocalData localData;
  final NetworkInfo networkInfo;
  Map<String, String> headers = {};

  MainRepository({
    required this.remoteData,
    // required this.localData,
    required this.networkInfo,
  }) {
    _initializeHeaders();
  }

  Future<void> _initializeHeaders() async {
    String token =
        await SecureStorageService().read(
          key: SharPrefConstants.userLoginTokenKey,
        ) ??
        '';
    headers = {
      'Accept': 'text/plain',
      HttpHeaders.contentTypeHeader: ContentType.json.mimeType,
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
  }
}
