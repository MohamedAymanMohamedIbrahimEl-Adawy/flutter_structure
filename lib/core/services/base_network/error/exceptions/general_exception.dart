import '../handler/error_handler.dart';

class GeneralException extends ErrorHandler {
  String exception;

  GeneralException(this.exception);

  @override
  String toString() {
    return exception;
  }
}
