import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:cleanarchitecture/core/services/base_network/client/dio_client.dart';
import 'package:cleanarchitecture/core/data/constants/app_router.dart';
import 'package:cleanarchitecture/core/data/constants/global_obj.dart';
import 'package:cleanarchitecture/core/global/state/base_state.dart';
import 'package:cleanarchitecture/features/more/domain/use_case/logout_use_case.dart';
part 'logout_event.dart';

class LogoutBloc extends Bloc<LogoutEvent, BaseState> {
  final LogoutUseCase logoutUseCase;
  LogoutBloc({required this.logoutUseCase}) : super(ButtonEnabledState()) {
    on<ActionLogoutEvent>(onLogout);
  }
  Future<void> onLogout(
    ActionLogoutEvent event,
    Emitter<BaseState> emit,
  ) async {
    emit(const ButtonLoadingState());
    final logout = await logoutUseCase.logout();
    logout.fold(
      (l) {
        makeLogout(event.context, ErrorState(l));
        emit(ErrorState(l));
      },
      (r) async {
        makeLogout(event.context, LoadedState(r));
        emit(LoadedState(r));
      },
    );
  }

  makeLogout(BuildContext context, BaseState state) async {
    Navigator.pop(context);
    await DioClient().deleteToken();
    if (state is LoadedState) {
      navigatorKey.currentState!.context.go(AppRouter.login);
    }
  }
}
