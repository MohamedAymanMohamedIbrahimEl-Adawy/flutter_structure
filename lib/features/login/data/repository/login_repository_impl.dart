import 'package:dartz/dartz.dart';
import 'package:cleanarchitecture/core/services/base_network/api_endpoints_constants.dart';
import 'package:cleanarchitecture/core/services/base_network/general_response_model.dart';
import 'package:cleanarchitecture/core/services/base_network/network_repository.dart';
import 'package:cleanarchitecture/features/login/data/model/login_response_model.dart';
import 'package:cleanarchitecture/features/login/domain/repository/login_repo.dart';

import '../../../../core/services/base_network/error/handler/error_model.dart';
import '../../../../core/services/base_network/error/handler/exception_enum.dart';
import '../model/login_request_model.dart';

class LoginRepositoryImpl extends MainRepository implements LoginRepository {
  LoginRepositoryImpl({
    required super.remoteData,
    required super.networkInfo, // For checking network connection
  });

  @override
  Future<Either> login({required LoginRequestModel model}) async {
    try {
      final result = await remoteData.post(
        body: model.toJson(),
        endPoint: ApiEndpointsConstants.login,
        headers: headers,
        model: GeneralResponseModel(model: LoginResponseModel()),
      );
      return result;
    } catch (e) {
      // If an error occurs, return the error wrapped in Left
      return Left(
        ErrorExceptionModel(
          message: e.toString(),
          exceptionEnum: ExceptionEnum.unknownException,
        ),
      );
    }
  }
}
