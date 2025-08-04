import 'package:dartz/dartz.dart';
import 'package:cleanarchitecture/features/communication_map/domain/repository/map_repo.dart';

class MapUseCase {
  final MapRepo mapRepo;

  MapUseCase({required this.mapRepo});

  Future<Either> getPoints() async {
    return await mapRepo.getPoints();
  }
}
