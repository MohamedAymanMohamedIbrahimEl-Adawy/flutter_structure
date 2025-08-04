import 'package:dartz/dartz.dart';

import '../../data/model/login_request_model.dart';

abstract class LoginRepository {
  Future<Either<dynamic, dynamic>> login({
    required LoginRequestModel model,
  });
}
