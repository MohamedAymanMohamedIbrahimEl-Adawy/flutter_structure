import 'package:dio/dio.dart';

import '../handler/error_handler.dart';
import '../handler/exception_enum.dart';

class UnAuthorizedTokenException extends ErrorHandler {
  UnAuthorizedTokenException(DioException exception);

  @override
  String toString() {
    return ExceptionEnum.unAuthorized.value;
  }
}
