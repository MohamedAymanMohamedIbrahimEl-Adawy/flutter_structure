import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:cleanarchitecture/core/services/base_network/error/handler/error_model.dart';
import 'package:cleanarchitecture/core/services/base_network/general_response_model.dart';
import 'package:cleanarchitecture/core/data/constants/app_router.dart';
import 'package:cleanarchitecture/core/extensions/string_extensions.dart';
import 'package:cleanarchitecture/core/global/state/base_state.dart';
import 'package:cleanarchitecture/core/services/device_info_manager.dart';
import 'package:cleanarchitecture/features/login/domain/use_case/login_use_case.dart';
import '../../../../core/data/constants/global_obj.dart';
import '../../../../core/data/constants/shared_preferences_constants.dart';
import '../../../../core/services/biometric_auth_service/biometric_auth_service.dart';
import '../../../../core/services/local_storage/secure_storage/secure_storage_service.dart';
import '../../../../core/services/local_storage/shared_preference/shared_preference_service.dart';
import '../../data/model/login_request_model.dart';
import '../../data/model/login_response_model.dart';

part 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent, BaseState> {
  final LoginUseCase loginUseCase;
  LoginBloc({required this.loginUseCase}) : super(ButtonDisabledState()) {
    on<NormalLoginEvent>(onNormalLogin);
    on<BiomatricLoginEvent>(onBiometricLogin);
    on<ValidationEvent>(onValidateAllFields);
    on<EnableBiometricEvent>(onEnableBiometric);
  }

  void onValidateAllFields(ValidationEvent event, Emitter emit) {
    if (!event.loginRequestModel.userName!.isEmptyOrNull &&
        !event.loginRequestModel.password.isEmptyOrNull &&
        event.loginRequestModel.password!.length <= 50 &&
        event.loginRequestModel.userName!.length <= 50) {
      emit(ButtonEnabledState());
    } else {
      emit(ButtonDisabledState());
    }
  }

  Future<void> onEnableBiometric(
    EnableBiometricEvent event,
    Emitter emit,
  ) async {
    emit(ButtonDisabledState());
  }

  Future<void> onNormalLogin(NormalLoginEvent event, Emitter emit) async {
    Get.context!.goNamed(AppRouter.home);
    return;
    emit(const ButtonLoadingState());
    String deviceID = await DeviceInfoManager.getDeviceIdentity();
    event.loginRequestModel.deviceID = deviceID;
    final response = await loginUseCase.login(event.loginRequestModel);
    await response.fold(
      (l) async {
        emit(ErrorState(l));
      },
      (r) async {
        if ((r).statusCode == 200 || (r).statusCode == 201) {
          if (event.saveLogin) {
            await SecureStorageService().clear();
            await SecureStorageService().write(
              key: SharPrefConstants.emailKey,
              value: event.loginRequestModel.userName ?? '',
            );
            await SecureStorageService().write(
              key: SharPrefConstants.passwordKey,
              value: event.loginRequestModel.password ?? '',
            );
          }

          await SharedPreferenceService().setBool(
            SharPrefConstants.isLoginKey,
            true,
          );
          await SecureStorageService().write(
            key: SharPrefConstants.userLoginTokenKey,
            value:
                ((r as GeneralResponseModel).model as LoginResponseModel)
                    .model
                    ?.token ??
                'token',
          );
          await SecureStorageService().write(
            key: SharPrefConstants.userRefreshTokenKey,
            value:
                ((r).model as LoginResponseModel).model?.refershToken ??
                'refershToken',
          );

          Get.context!.goNamed(AppRouter.home);
        } else {
          handleError(errors: r.errors ?? [], statusCode: r.statusCode ?? 0);
        }
        emit(LoadedState(r));
      },
    );
  }

  Future<void> onBiometricLogin(BiomatricLoginEvent event, Emitter emit) async {
    final BiometricAuthService biometricAuthService = BiometricAuthService();
    final bool isSuccess = await biometricAuthService.login(Get.context!);

    if (isSuccess) {
      Get.context!.goNamed(AppRouter.home);
      return;
      emit(const ButtonLoadingState(isFirstButtonLoading: false));

      String name =
          await SecureStorageService().read(key: SharPrefConstants.emailKey) ??
          '';
      String password =
          await SecureStorageService().read(
            key: SharPrefConstants.passwordKey,
          ) ??
          '';
      String deviceID = await DeviceInfoManager.getDeviceIdentity();

      final LoginRequestModel loginRequestModel = LoginRequestModel(
        deviceID: deviceID,
        userName: name,
        password: password,
        deviceToken: "globalFcmToken",
      );

      final response = await loginUseCase.login(loginRequestModel);

      await response.fold(
        (l) async {
          emit(ErrorState(l));
        },
        (r) async {
          await SecureStorageService().clear();
          await SecureStorageService().write(
            key: SharPrefConstants.emailKey,
            value: loginRequestModel.userName ?? '',
          );
          await SecureStorageService().write(
            key: SharPrefConstants.passwordKey,
            value: loginRequestModel.password ?? '',
          );
          await SharedPreferenceService().setBool(
            SharPrefConstants.isLoginKey,
            true,
          );
          await SecureStorageService().write(
            key: SharPrefConstants.userLoginTokenKey,
            value:
                ((r as GeneralResponseModel).model as LoginResponseModel)
                    .model
                    ?.token ??
                'token',
          );
          await SecureStorageService().write(
            key: SharPrefConstants.userRefreshTokenKey,
            value:
                ((r).model as LoginResponseModel).model?.refershToken ??
                'refershToken',
          );
          if (!emit.isDone) {
            emit(LoadedState(r));
          }
          Get.context!.goNamed(AppRouter.home);
        },
      );
    }
  }
}
