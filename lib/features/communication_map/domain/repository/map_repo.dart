import 'package:dartz/dartz.dart';

abstract class MapRepo {
  Future<Either<dynamic, dynamic>> getPoints();
}
