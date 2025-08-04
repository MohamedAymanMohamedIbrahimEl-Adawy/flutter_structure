import '../handler/error_handler.dart';
import '../handler/exception_enum.dart';

class ConnectionErrorException extends ErrorHandler {
  @override
  String toString() {
    return ExceptionEnum.connectionErrorException.value;
  }
}
