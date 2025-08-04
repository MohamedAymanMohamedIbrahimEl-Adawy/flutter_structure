import 'dart:io';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:cleanarchitecture/core/services/base_network/client/dio_client.dart';
import 'package:cleanarchitecture/core/component/inspector/inspector_model.dart';
import 'package:cleanarchitecture/core/data/constants/shared_preferences_constants.dart';
import 'package:cleanarchitecture/core/services/log/app_log.dart';
import '../../local_storage/secure_storage/secure_storage_service.dart';

List<InspectorModel> inspectList = [];
InspectorModel? inspectorModel;

class RequestInterceptor extends Interceptor {
  RequestInterceptor();
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    inspectorModel = InspectorModel();
    await DioClient().updateHeader();
    options.extra['startTime'] = DateTime.now();
    String token =
        await SecureStorageService().read(
          key: SharPrefConstants.userLoginTokenKey,
        ) ??
        '';
    options.headers['Authorization'] = 'Bearer $token';
    options.headers['API-REQUEST-FROM'] = Platform.isIOS ? "IOS" : "Android";
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    Duration difference = response.requestOptions.extra['startTime'].difference(
      inspectorModel!.startTimeDate ?? DateTime.now(),
    );
    int seconds = difference.inSeconds % 60;
    int milliseconds = difference.inMilliseconds % 60;
    String formattedDifference =
        seconds != 0 ? "$seconds s , $milliseconds ms" : "$milliseconds ms";
    if (response.statusCode == 200 || response.statusCode == 201) {
      inspectList.add(
        InspectorModel(
          extra: response.requestOptions.extra,
          queryParameters: response.requestOptions.queryParameters,
          uri: response.requestOptions.uri,
          responseBody: response.data,
          authorization: response.requestOptions.headers['Authorization'] ?? '',
          startTime: DateFormat(
            'MM/dd/yyyy hh:mm:ss a',
          ).format(response.requestOptions.extra['startTime']),
          startTimeDate: response.requestOptions.extra['startTime'],
          data: response.requestOptions.data,
          baseUrl: response.requestOptions.baseUrl,
          contentType: response.headers.value('content-type'),
          endTime: DateFormat('MM/dd/yyyy hh:mm:ss a').format(DateTime.now()),
          method: response.requestOptions.method,
          path: response.requestOptions.path,
          callingTime: formattedDifference,
          statusCode: response.statusCode,
        ),
      );
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if ((err.response?.statusCode ?? 0) != 200 ||
        (err.response?.statusCode ?? 0) != 201) {
      try {
        DateTime date =
            err.response?.requestOptions.extra['startTime'] ??
            err.requestOptions.extra['startTime'];
        Duration difference = date.difference(
          inspectorModel!.startTimeDate ?? DateTime.now(),
        );
        int seconds = difference.inSeconds % 60;
        int milliseconds = difference.inMilliseconds % 60;
        String formattedDifference =
            seconds != 0 ? "$seconds s , $milliseconds ms" : "$milliseconds ms";
        String authorization =
            err.response?.requestOptions.headers['Authorization'] ??
            err.requestOptions.headers['Authorization'];
        dynamic queryParameters =
            err.response?.requestOptions.queryParameters ??
            err.requestOptions.queryParameters;
        Uri uri = err.response?.requestOptions.uri ?? err.requestOptions.uri;
        String data =
            (err.response?.requestOptions.data ?? err.requestOptions.data)
                .toString();
        String baseUrl =
            err.response?.requestOptions.baseUrl ?? err.requestOptions.baseUrl;
        // dynamic responseBody=err.response?.requestOptions.data??err.response?.data??'';
        dynamic responseBody = err.response?.data.toString();
        String contentType =
            (err.response?.requestOptions.headers['content-type'] ??
                    err.requestOptions.headers['content-type'])
                .toString();
        String method =
            err.response?.requestOptions.method ?? err.requestOptions.method;
        String path =
            err.response?.requestOptions.path ?? err.requestOptions.path;
        int statusCode = err.response?.statusCode ?? 504;
        inspectList.add(
          InspectorModel(
            error: err.toString(),
            startTime: DateFormat('MM/dd/yyyy hh:mm:ss a').format(date),
            startTimeDate: date,
            extra: err.response?.requestOptions.extra,
            authorization: authorization,
            queryParameters: queryParameters,
            uri: uri,
            data: data,
            baseUrl: baseUrl,
            responseBody: responseBody,
            path: path,
            contentType: contentType,
            method: method,
            endTime: DateFormat('MM/dd/yyyy hh:mm:ss a').format(DateTime.now()),
            callingTime: formattedDifference,
            statusCode: statusCode,
          ),
        );
      } catch (e) {
        AppLog.logValue(e);
      }
    }
    super.onError(err, handler);
  }
}
