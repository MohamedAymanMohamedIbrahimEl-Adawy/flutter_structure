import 'package:cleanarchitecture/core/services/base_network/error/handler/exception_enum.dart';

import '../handler/error_handler.dart';

class ConnectionTimeoutException extends ErrorHandler {
  @override
  String toString() {
    return ExceptionEnum.connectionTimeOutException.value;
  }
}
