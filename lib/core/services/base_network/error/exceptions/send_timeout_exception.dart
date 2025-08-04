import '../handler/error_handler.dart';

class SendTimeoutException extends ErrorHandler {
  @override
  String toString() {
    // return ExceptionEnum.sendTimeoutException.value;
    return 'انتهاء مهلة الإرسال';
  }
}
