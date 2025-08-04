import '../handler/error_handler.dart';

class ServerErrorException extends ErrorHandler {
  @override
  String toString() {
    return 'some Thing Went Wrong';
  }
}
