import 'package:dartz/dartz.dart';

abstract class LogoutRepository {
  Future<Either<dynamic, dynamic>> logout();
}
