import 'package:dio/dio.dart';
import 'package:cleanarchitecture/core/services/log/app_log.dart';

import 'exception_enum.dart';

class DioExceptionHandler {
  ExceptionEnum handleException(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.connectionError:
        return ExceptionEnum.connectionErrorException;
      case DioExceptionType.connectionTimeout:
        return ExceptionEnum.connectionTimeOutException;
      case DioExceptionType.sendTimeout:
        return ExceptionEnum.sendTimeoutException;
      case DioExceptionType.receiveTimeout:
        return ExceptionEnum.receiveTimeoutException;
      case DioExceptionType.cancel:
        return ExceptionEnum.cancelException;
      case DioExceptionType.badResponse:
        // AppLog.printValue('Bad Response : ${exception.response?.statusCode}');
        if (exception.response?.statusCode == 400) {
          return ExceptionEnum.badRequest;
        } else if (exception.response?.statusCode == 401) {
          return ExceptionEnum.unAuthorized;
        } else if (exception.response?.statusCode == 403) {
          return ExceptionEnum.connectionErrorException;
        } else if (exception.response?.statusCode == 404) {
          return ExceptionEnum.pageNotFound;
        } else if (exception.response?.statusCode == 406) {
          return ExceptionEnum.refreshTokenExpired;
        } else if (exception.response?.statusCode == 429) {
          return ExceptionEnum.blockedUser;
        } else if (exception.response?.statusCode == 500) {
          return ExceptionEnum.serverError;
        } else if (exception.response != null &&
            exception.response?.data != null &&
            exception.response?.data != '' &&
            exception.response?.data?['errors'] != null &&
            exception.response?.data?['errors'] != []) {
          return ExceptionEnum.fromValue(
            exception.response?.data['errors'][0]['errorCode'],
          );
        } else {
          return ExceptionEnum.badResponseException;
        }

      case DioExceptionType.badCertificate:
        return ExceptionEnum.badCertificateResponseException;
      case DioExceptionType.unknown:
        return ExceptionEnum.unknownException;
    }
  }

  String getErrorMessage(dynamic error) {
    String errorMessage = "anErrorOccurred";
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.unknown:
          if ((error.error ?? '').toString().contains('Connection')) {
            errorMessage = "تعذر الاتصال";
          } else {
            errorMessage = "Unknown error";
          }
          break;
        case DioExceptionType.cancel:
          errorMessage = "Request to API server was cancelled";
          break;
        case DioExceptionType.connectionTimeout:
          errorMessage = "تعذر الاتصال";
          break;

        case DioExceptionType.receiveTimeout:
          errorMessage = "تعذر الاتصال";
          break;
        case DioExceptionType.badResponse:
          switch (error.response!.statusCode) {
            case 400:
              AppLog.printValue(
                '<==Here is error body== ${error.response!.data.toString()} ===>',
              );
              if (error.response!.data['errors'] != null) {
                List<dynamic> errors = error.response!.data['errors'];
                // print('errors>>'+errors.toString());
                errorMessage = errors
                    .map((e) {
                      if (e is Map && e.containsKey('message')) {
                        return e['message'].toString();
                      } else {
                        return e.toString();
                      }
                    })
                    .join('\n');
                // errorMessage = errors.map((e) => e['message']).join('\n');
                // errorMessage = errors.first['message'];
              } else if (error.response!.data['message'] != null) {
                errorMessage = error.response!.data['message'];
              } else {
                errorMessage = error.response!.data.toString();
              }
              break;
            case 401:
              AppLog.printValue(
                '<==Here is error body== ${error.response!.data} ===>',
              );
              if (error.response!.data == null || error.response!.data == '') {
                errorMessage = "Un authorized 401";
              }
              // else if (error.response!.data['errors'] != null) {
              //   errorMessage = error.response!.data['errors'][0]['message'];
              // }
              else if (error.response!.data['errors'] != null) {
                List<dynamic> errors = error.response!.data['errors'];
                errorMessage = errors.map((e) => e['message']).join('\n');
              } else if (error.response!.data['message'] != null) {
                errorMessage = error.response!.data['message'];
              } else {
                errorMessage = error.response!.data.toString();
              }
              break;
            case 403:
              AppLog.printValue(
                '<==Here is error body== ${error.response!.data} ===>',
              );
              // if (error.response!.data['errors'] != null) {
              //   errorMessage = error.response!.data['errors'][0]['message'];
              // }
              if (error.response!.data['errors'] != null) {
                List<dynamic> errors = error.response!.data['errors'];
                errorMessage = errors.map((e) => e['message']).join('\n');
              } else if (error.response!.data['message'] != null) {
                errorMessage = error.response!.data['message'];
              } else {
                errorMessage = error.response!.data.toString();
              }
              break;
            case 404:
              errorMessage = "Page not found";
            case 406:
              errorMessage = "Refresh token is expired";
            case 429:
              AppLog.printValue(
                '<==Here is error body== ${error.response!.data} ===>',
              );
              // if (error.response!.data['errors'] != null) {
              //   errorMessage = error.response!.data['errors'][0]['message'];
              // }
              if (error.response!.data['errors'] != null) {
                List<dynamic> errors = error.response!.data['errors'];
                errorMessage = errors.map((e) => e['message']).join('\n');
              } else if (error.response!.data['message'] != null) {
                errorMessage = error.response!.data['message'];
              } else {
                errorMessage = "User is blocked";
              }
              break;
            case 500:
              errorMessage = "Internal server error";

            case 503:
              break;
            default:
              errorMessage =
                  "Failed to load data - status code: ${error.response!.statusCode}";
          }
          break;
        case DioExceptionType.sendTimeout:
          errorMessage = "تعذر الاتصال";
          break;
        default:
          errorMessage = 'لقد حدث خطأ';
          break;
      }
    } else {
      errorMessage = "Unexpected error occured";
    }
    AppLog.logValue(errorMessage);
    return errorMessage;
  }
}
