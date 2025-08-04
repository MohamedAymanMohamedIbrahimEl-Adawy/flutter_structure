import '../handler/error_handler.dart';

class ReceiveTimeoutException extends ErrorHandler {
  @override
  String toString() {
    // return ExceptionEnum.receiveTimeoutException.value;
    return 'انتهاء مهلة الاستقبال';
  }
}
