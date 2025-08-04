import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:cleanarchitecture/core/data/constants/app_router.dart';
import 'package:cleanarchitecture/core/data/constants/global_obj.dart';
import 'package:cleanarchitecture/core/data/constants/shared_preferences_constants.dart';
import 'package:cleanarchitecture/core/services/local_storage/shared_preference/shared_preference_service.dart';
import 'package:cleanarchitecture/features/Splash/presentation/bloc/splash_event.dart';
import '../../../../../core/global/state/base_state.dart';

class SplashBloc extends Bloc<SplashEvent, BaseState> {
  AnimationController? controller;
  Animation<double>? scaleAnimation;

  SplashBloc() : super(const InitialState()) {
    on<SplashInitEvent>(onInit);
  }

  Future<void> onInit(SplashInitEvent event, Emitter<BaseState> emit) async {
    callAnimation(vsync: event.vsync);
  }

  callAnimation({required TickerProvider vsync}) {
    controller = AnimationController(
      vsync: vsync,
      duration: const Duration(seconds: 3),
    );
    scaleAnimation = Tween<double>(
      begin: 0.1,
      end: 1,
    ).animate(CurvedAnimation(parent: controller!, curve: Curves.easeInOut));
    controller!.forward();
    navigateTo();
  }

  navigateTo() {
    bool isLoginKey = SharedPreferenceService().getBool(
      SharPrefConstants.isLoginKey,
    );
    controller!.addStatusListener((status) {
      if (isLoginKey) {
        if (status == AnimationStatus.completed) {
          Get.context!.goNamed(AppRouter.home);
        }
      } else {
        if (status == AnimationStatus.completed) {
          Get.context!.goNamed(AppRouter.login);
        }
      }
    });
  }
}
