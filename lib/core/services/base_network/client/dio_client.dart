import 'dart:developer';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:cleanarchitecture/core/services/base_network/api_endpoints_constants.dart';
import 'package:cleanarchitecture/core/services/base_network/error/handler/error_model.dart';
import 'package:cleanarchitecture/core/services/base_network/error/handler/exception_enum.dart';
import 'package:cleanarchitecture/core/services/base_network/interceptors/request_interceptor.dart';
import 'package:cleanarchitecture/core/services/base_network/interceptors/token_interceptor.dart';
import 'package:cleanarchitecture/core/data/constants/shared_preferences_constants.dart';
import 'package:cleanarchitecture/core/services/flavorizer/flavors_managment.dart';
import 'package:cleanarchitecture/core/services/local_storage/secure_storage/secure_storage_service.dart';
import 'package:cleanarchitecture/core/services/local_storage/shared_preference/shared_preference_service.dart';
import 'package:cleanarchitecture/core/services/log/app_log.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioClient {
  // Set base url base on Flavors
  String baseUrl() =>
      FlavorsManagement.instance.getCurrentFlavor().baseUrl ??
      ApiEndpointsConstants.baseUrl;

  // late final dio = Dio();
  late Dio dio;

  String? accessToken;
  dynamic headers;

  DioClient() {
    dio = Dio();
    dio
      ..options.baseUrl = baseUrl()
      ..options.connectTimeout = const Duration(seconds: 15)
      ..options.sendTimeout = const Duration(seconds: 60)
      ..options.receiveTimeout = const Duration(seconds: 60)
      ..httpClientAdapter
      ..options.headers = headers;
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        maxWidth: 90,
        enabled: kDebugMode,
        compact: false,
        logPrint: (object) => log(object.toString(), name: 'Test'),
      ),
    );
    dio.interceptors.add(RequestInterceptor());
    dio.interceptors.add(TokenInterceptor(dio));
    // dio.interceptors.add(NetworkInterceptor(NetworkCubit(Connectivity())));
    // dio.interceptors.add(RetryInterceptor(dio: dio, retries: 40, retryDelay: 0));
  }

  Future<dynamic> get({
    required String endPoint,
    Map<String, String>? headers,
    Map<String, String>? queryParameters = const {},
    required dynamic model,
  }) async {
    if (headers != null && headers.isNotEmpty) {
    } else {
      headers = await addHeader();
    }
    try {
      final response = await dio.get(
        endPoint,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      switch (response.statusCode) {
        case HttpStatus.ok:
        case HttpStatus.created:
          {
            return Right(
              _jsonBodyParser(requestModel: model, responseBody: response.data),
            );
          }
        case HttpStatus.unauthorized:
          return Left(
            ErrorExceptionModel(
              exceptionEnum: ExceptionEnum.unAuthorized,
              message: 'un authorized',
            ),
          );
        default:
          throw response.data;
      }
    } catch (e) {
      AppLog.printValue('errrrr>>$e');
      return Left(ErrorExceptionModel.fromJson(e));
    }
  }

  Future<dynamic> post({
    required String endPoint,
    Map<String, String>? headers,
    Object? body = const {},
    Map<String, dynamic>? queryParameters = const {},
    required model,
  }) async {
    try {
      final response = await dio.post(
        endPoint,
        queryParameters: queryParameters,
        options: Options(headers: headers),
        data: body,
      );
      switch (response.statusCode) {
        case HttpStatus.ok:
        case HttpStatus.created:
          {
            return Right(
              _jsonBodyParser(requestModel: model, responseBody: response.data),
            );
          }
        default:
          throw response.data;
      }
    } catch (e) {
      AppLog.printValue(e);
      // showErrorToast(ErrorModel.fromJson(e).message ?? '');
      return Left(ErrorExceptionModel.fromJson(e));
    }
  }

  Future<dynamic> postMultiPartDataNew({
    required dynamic body,
    required String endPoint,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters = const {},
    required model,
  }) async {
    try {
      Map<String, String>? modfiedHeader = headers;
      modfiedHeader!['Content-type'] = 'multipart/form-data';
      FormData formData = FormData.fromMap({
        ...body.toMap(),
        if (body!.file != null)
          "file": await MultipartFile.fromFile(
            body!.file!,
            filename: basename(body.file!),
          ),
      });
      // print('formData>>'+formData.fields.toString());
      // Create a FormData object
      final response = await dio.post(
        endPoint,
        queryParameters: queryParameters,
        options: Options(
          contentType: "multipart/form-data",
          headers: modfiedHeader,
        ),
        data: formData,
      );
      switch (response.statusCode) {
        case HttpStatus.ok:
        case HttpStatus.created:
          {
            return Right(
              _jsonBodyParser(requestModel: model, responseBody: response.data),
            );
          }
        default:
          throw response.data;
      }

      // Handle response
      // if (response.statusCode == 200) {
      //AppLog.printValueAndTitle("Upload successful: ${response.data}");
      // } else {
      //AppLog.printValueAndTitle("Upload failed: ${response.statusMessage}");
      // }
    } catch (e) {
      return Left(ErrorExceptionModel.fromJson(e));
    }
  }

  // Future<dynamic> put<T extends BaseModel>({
  Future<dynamic> put({
    required String endPoint,
    Map<String, String>? headers,
    Object? body = const {},
    Map<String, dynamic>? queryParameters = const {},
    required model,
  }) async {
    try {
      final response = await dio.put(
        endPoint,
        data: body,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      switch (response.statusCode) {
        case HttpStatus.ok:
        case HttpStatus.created:
          {
            return Right(
              _jsonBodyParser(requestModel: model, responseBody: response.data),
            );
          }
        case HttpStatus.forbidden:
          return response.data;
        case HttpStatus.unprocessableEntity:
          return 'Check request key';
        case HttpStatus.unauthorized:
          return "403";
        case HttpStatus.notFound:
          return "404";
        default:
          throw response.data;
      }
    } catch (e) {
      // showErrorToast(ErrorModel.fromJson(e).message ?? '');
      return Left(ErrorExceptionModel.fromJson(e));
    }
  }

  Future<dynamic> delete({
    required String endPoint,
    Map<String, String>? headers,
    Object? body = const {},
    Map<String, dynamic>? queryParameters = const {},
    required model,
  }) async {
    try {
      final response = await dio.delete(
        endPoint,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      switch (response.statusCode) {
        case HttpStatus.ok:
        case HttpStatus.created:
          {
            return Right(
              _jsonBodyParser(requestModel: model, responseBody: response.data),
            );
          }
        case HttpStatus.forbidden:
          return response.data;
        case HttpStatus.unprocessableEntity:
          return 'Check request key';
        case HttpStatus.unauthorized:
          return "401";
        case HttpStatus.notFound:
          return "404";
        default:
          throw response.data;
      }
    } catch (e) {
      // showErrorToast(ErrorModel.fromJson(e).message ?? '');
      return Left(ErrorExceptionModel.fromJson(e));
    }
  }

  dynamic _jsonBodyParser({
    required dynamic requestModel,
    required dynamic responseBody,
  }) {
    return requestModel.fromMap(responseBody);
  }

  Future<Map<String, String>> addHeader() async {
    String accessToken =
        await SecureStorageService().read(
          key: SharPrefConstants.userLoginTokenKey,
        ) ??
        '';
    AppLog.logValue('accessToken>>$accessToken');
    headers =
        dio
          ..options.headers = {
            'Accept': 'text/plain',
            'Content-Type': 'application/json; charset=UTF-8',
            HttpHeaders.contentTypeHeader: ContentType.json.mimeType,
            HttpHeaders.authorizationHeader: 'Bearer $accessToken',
          };
    return {
      'Accept': 'text/plain',
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.contentTypeHeader: ContentType.json.mimeType,
      HttpHeaders.authorizationHeader: 'Bearer $accessToken',
    };
  }

  Future<void> updateHeader() async {
    accessToken = await SecureStorageService().read(
      key: SharPrefConstants.userLoginTokenKey,
    );
    AppLog.logValue('accessToken>> $accessToken');
    headers =
        dio
          ..options.headers = {
            'Accept': 'text/plain',
            'Content-Type': 'application/json; charset=UTF-8',
            HttpHeaders.contentTypeHeader: ContentType.json.mimeType,
            HttpHeaders.authorizationHeader: 'Bearer ${accessToken ?? ''}',
          };
  }

  Future<void> deleteToken() async {
    // await FirebaseMessaging.instance.deleteToken();
    // globalFcmToken = null;
    await SecureStorageService().write(
      key: SharPrefConstants.userLoginTokenKey,
      value: '',
    );
    await SharedPreferenceService().setBool(
      SharPrefConstants.isLoginKey,
      false,
    );
  }
}
