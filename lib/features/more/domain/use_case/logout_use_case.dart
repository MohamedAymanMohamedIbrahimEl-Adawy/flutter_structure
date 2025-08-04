import 'package:dartz/dartz.dart';
import 'package:cleanarchitecture/features/more/domain/repository/logout_repo.dart';

class LogoutUseCase {
  final LogoutRepository logoutRepository;

  LogoutUseCase({required this.logoutRepository});

  Future<Either> logout() async {
    return await logoutRepository.logout();
  }
}
