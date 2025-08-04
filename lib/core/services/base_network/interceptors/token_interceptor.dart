import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import 'package:cleanarchitecture/core/services/base_network/api_endpoints_constants.dart';
import 'package:cleanarchitecture/core/services/base_network/client/dio_client.dart';
import 'package:cleanarchitecture/core/services/base_network/error/handler/error_model.dart';
import 'package:cleanarchitecture/core/component/custom_toast/p_toast.dart';
import 'package:cleanarchitecture/core/data/constants/app_router.dart';
import 'package:cleanarchitecture/core/data/constants/global_obj.dart';
import 'package:cleanarchitecture/core/data/constants/shared_preferences_constants.dart';
import 'package:cleanarchitecture/core/global/enums/global_enum.dart';
import 'package:cleanarchitecture/core/services/flavorizer/flavors_managment.dart';
import 'package:cleanarchitecture/core/services/local_storage/secure_storage/secure_storage_service.dart';

import '../../../global/global_func.dart';

class TokenInterceptor extends InterceptorsWrapper {
  final Dio dio;
  Completer<bool?>? _refreshCompleter;

  TokenInterceptor(this.dio);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    String accessToken =
        await SecureStorageService().read(
          key: SharPrefConstants.userLoginTokenKey,
        ) ??
        '';
    if (accessToken.isNotEmpty) {
      options.headers = {
        'Accept': 'text/plain',
        HttpHeaders.contentTypeHeader: ContentType.json.mimeType,
        'Content-type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
      };
    }
    return handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final currentLocation =
        GoRouter.of(Get.navigatorState!.context).state?.fullPath;

    // If not 401, show error and forward
    if (err.response?.statusCode != 401 && err.response?.statusCode != 406) {
      SafeToast.show(
        message:
            ErrorExceptionModel.fromJson(err).message ??
            'Something went wrong!',
        type: MessageType.error,
      );
      return handler.next(err);
    }
    if (currentLocation == AppRouter.login && err.response?.statusCode == 401) {
      SafeToast.show(
        message:
            ErrorExceptionModel.fromJson(err).message ??
            'Something went wrong!',
        type: MessageType.error,
      );
      return handler.next(err);
    }

    // If 401 - start or wait for refresh
    if (err.response?.statusCode == 401) {
      late final Completer<bool?> completer;

      if (_refreshCompleter == null) {
        _refreshCompleter = Completer<bool?>();
        completer = _refreshCompleter!;

        final refreshed = await refreshAccessToken(dio);
        _refreshCompleter?.complete(refreshed);
        _refreshCompleter = null;
      } else {
        completer = _refreshCompleter!;
      }

      final refreshResult = await completer.future;

      if (refreshResult == true) {
        // Retry the failed request
        try {
          final newAccessToken =
              await SecureStorageService().read(
                key: SharPrefConstants.userLoginTokenKey,
              ) ??
              '';
          final retryRequest = err.requestOptions;

          retryRequest.headers = {
            'Accept': 'text/plain',
            HttpHeaders.contentTypeHeader: ContentType.json.mimeType,
            'Content-type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $newAccessToken',
          };

          final response = await dio.fetch(retryRequest);
          return handler.resolve(response);
        } catch (e) {
          return handler.next(err); // Failed to retry
        }
      } else {
        await navigateToLogin();
        return;
      }
    }
    return handler.next(err);
  }
}

Future<bool?> refreshAccessToken(Dio dio) async {
  try {
    String refreshToken =
        await SecureStorageService().read(
          key: SharPrefConstants.userRefreshTokenKey,
        ) ??
        '';
    String baseUrl() =>
        FlavorsManagement.instance.getCurrentFlavor().baseUrl ??
        ApiEndpointsConstants.baseUrl;
    final response = await dio.post(
      '${baseUrl()}${ApiEndpointsConstants.getRefreshToken}?refreshToken=$refreshToken',
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      final newAccessToken = response.data['model']['token'];
      final newRefreshToken = response.data['model']['refershToken'];
      await DioClient().updateHeader();
      await saveTokens(newAccessToken, newRefreshToken);
      return true;
    }
  } on DioException catch (e) {
    if (e.response?.statusCode == 406) {
      return false;
    }
  }
  return null;
}

Future<void> saveTokens(String accessToken, String newRefreshToken) async {
  await SecureStorageService().write(
    key: SharPrefConstants.userLoginTokenKey,
    value: accessToken,
  );
  await SecureStorageService().write(
    key: SharPrefConstants.userRefreshTokenKey,
    value: newRefreshToken,
  );
}

Future<void> navigateToLogin() async {
  await DioClient().deleteToken();

  // if (Navigator.canPop(Get.context!)) {
  //   Navigator.of(Get.context!, rootNavigator: true).pop();
  // }
  navigatorKey.currentState?.context.go(AppRouter.login);
  // Clear token and navigate to login
  hideLoadingDialog();
}
