import 'package:dartz/dartz.dart';
import 'package:cleanarchitecture/core/services/base_network/api_endpoints_constants.dart';
import 'package:cleanarchitecture/core/services/base_network/network_repository.dart';
import 'package:cleanarchitecture/features/more/data/model/logout_response_model.dart';
import 'package:cleanarchitecture/features/more/domain/repository/logout_repo.dart';

import '../../../../core/services/base_network/general_response_model.dart';

class LogoutRepositoryImpl extends MainRepository implements LogoutRepository {
  LogoutRepositoryImpl({
    required super.remoteData,
    required super.networkInfo, // For checking network connection
  });

  @override
  Future<Either> logout() async {
    final result = await remoteData.post(
      endPoint: ApiEndpointsConstants.logout,
      headers: headers,
      model: GeneralResponseModel(model: LogoutResponseModel()),
    );
    return result;
  }
}
