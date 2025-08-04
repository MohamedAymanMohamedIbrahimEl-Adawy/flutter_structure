import 'package:dartz/dartz.dart';
import '../../data/model/login_request_model.dart';
import '../repository/login_repo.dart';

class LoginUseCase {
  final LoginRepository loginRepository;

  LoginUseCase({required this.loginRepository});

  Future<Either> login(LoginRequestModel params) async {
    return await loginRepository.login(model: params);
  }
}
