import 'package:dio/dio.dart';
import 'package:cleanarchitecture/core/services/base_network/error/handler/exception_enum.dart';

import '../exceptions/connection_error_exception.dart';
import '../exceptions/connection_timeout_exception.dart';
import '../exceptions/general_exception.dart';
import '../exceptions/receive_timeout_exception.dart';
import '../exceptions/send_timeout_exception.dart';
import '../exceptions/server_error_exception.dart';
import '../exceptions/un_authorized_token_exception.dart';

class ErrorHandler {
  ErrorHandler();

  factory ErrorHandler.exception(
    ExceptionEnum exceptionEnum,
    Exception exception,
  ) {
    switch (exceptionEnum) {
      case ExceptionEnum.generalException:
        return GeneralException(ExceptionEnum.generalException.value);
      case ExceptionEnum.unAuthorized:
        return UnAuthorizedTokenException(exception as DioException);
      case ExceptionEnum.serverError:
        return ServerErrorException();
      case ExceptionEnum.connectionErrorException:
        return ConnectionErrorException();
      case ExceptionEnum.connectionTimeOutException:
        return ConnectionTimeoutException();
      case ExceptionEnum.sendTimeoutException:
        return SendTimeoutException();
      case ExceptionEnum.receiveTimeoutException:
        return ReceiveTimeoutException();

      ///==========

      case ExceptionEnum.cancelException:
      case ExceptionEnum.badResponseException:
      case ExceptionEnum.badCertificateResponseException:
      case ExceptionEnum.unknownException:
      case ExceptionEnum.formatException:
      case ExceptionEnum.docTypeHtmlException:
      default:
        return GeneralException(exceptionEnum.value);
    }
  }
}
