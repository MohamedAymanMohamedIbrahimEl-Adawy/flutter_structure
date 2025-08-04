import 'package:dartz/dartz.dart';
import 'package:cleanarchitecture/core/services/base_network/api_endpoints_constants.dart';
import 'package:cleanarchitecture/core/services/base_network/network_repository.dart';
import 'package:cleanarchitecture/features/communication_map/data/model/map_response_model.dart';
import 'package:cleanarchitecture/features/communication_map/domain/repository/map_repo.dart';

import '../../../../core/services/base_network/general_response_model.dart';

class MapRepositoryImpl extends MainRepository implements MapRepo {
  MapRepositoryImpl({
    required super.remoteData,
    required super.networkInfo, // For checking network connection
  });

  @override
  Future<Either> getPoints() async {
    final result = await remoteData.get(
      endPoint: ApiEndpointsConstants.pointsMap,
      headers: headers,
      model: GeneralResponseModel(model: MapResponseModel()),
    );
    return result;
  }
}
