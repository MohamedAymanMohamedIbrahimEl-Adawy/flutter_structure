import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:cleanarchitecture/core/component/custom_toast/p_toast.dart';
import 'package:cleanarchitecture/core/global/enums/global_enum.dart';
import '../../general_response_model.dart';
import 'dio_exception_handler.dart';
import 'exception_enum.dart';

class ErrorExceptionModel implements BaseErrorModel {
  String? message;
  ExceptionEnum? exceptionEnum;

  ErrorExceptionModel({this.message, this.exceptionEnum});

  factory ErrorExceptionModel.fromJson(dynamic exception) {
    // logError(exception);

    ExceptionEnum exceptionEnum = ExceptionEnum.unknownException;
    String? errorMessage;
    switch (exception.runtimeType) {
      case const (DioException):
        exceptionEnum = DioExceptionHandler().handleException(exception);
        errorMessage = DioExceptionHandler().getErrorMessage(exception);
        break;
      case const (SocketException):
        exceptionEnum = ExceptionEnum.connectionErrorException;
        break;
      case const (FormatException):
        exceptionEnum = ExceptionEnum.formatException;
        break;
      case const (TimeoutException):
        exceptionEnum = ExceptionEnum.connectionTimeOutException;
        break;
      case const (HttpException):
        exceptionEnum = ExceptionEnum.connectionErrorException;
        break;
      default:
        if (exception is String) {
          if (exception.startsWith('<!DOCTYPE html>')) {
            exceptionEnum = ExceptionEnum.docTypeHtmlException;
          } else {
            exceptionEnum = ExceptionEnum.generalException;
          }
        }
        break;
    }
    return ErrorExceptionModel(
      // message: ErrorHandler.exception(exceptionEnum, exception).toString(),
      message: errorMessage,
      exceptionEnum: exceptionEnum,
    );
  }

  @override
  String toString() {
    return 'ErrorModel(message: : $message, exceptionEnum: ${exceptionEnum?.name} )';
  }
}

interface class BaseErrorModel {}

handleError({required List<Errors> errors, required int statusCode}) {
  if (statusCode != 401) {
    if (errors.isNotEmpty) {
      String errorMessage = errors
          .where((error) => error.message != null && error.message!.isNotEmpty)
          .map((error) => error.message)
          .join('\n');
      if (errorMessage.isNotEmpty) {
        if (statusCode != 406 && statusCode != 401) {
          SafeToast.show(
            // context: navigatorKey.currentState!.context,
            message: errorMessage,
            type: MessageType.error,
          );
        }
      }
    }
  }
}
