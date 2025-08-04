import '../../../../core/services/base_network/network_repository.dart';
import '../../domain/repo/home_repository.dart';

class HomeRepositoryImpl extends MainRepository implements HomeRepository {
  HomeRepositoryImpl({required super.remoteData, required super.networkInfo});
}
