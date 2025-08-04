import '../handler/error_handler.dart';

class WrongDateException extends ErrorHandler {
  @override
  String toString() {
    return 'wrong Date';
  }
}
