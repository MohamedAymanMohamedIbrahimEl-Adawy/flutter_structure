import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cleanarchitecture/core/data/assets_helper/app_icon.dart';
import 'package:cleanarchitecture/core/data/constants/shared_preferences_constants.dart';
import 'package:cleanarchitecture/core/services/local_storage/shared_preference/shared_preference_service.dart';
import '../../../../core/data/constants/app_router.dart';
import '../../../../core/services/local_storage/secure_storage/secure_storage_service.dart';
import '../../../../core/services/log/app_log.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
    _scaleAnimation = Tween<double>(begin: 0.1, end: 1.1).animate(_controller);
    navigateTo();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  navigateTo() {
    Future.delayed(const Duration(seconds: 2), () async {
      if (!mounted) return;
      bool isFirstLaunch = SharedPreferenceService().getBool(
        SharPrefConstants.isFirstTimeToOpenAppKey,
        defaultValue: true,
      );

      AppLog.printValueAndTitle('isFirstOpen', isFirstLaunch);
      if (isFirstLaunch) {
        // Fresh install detected, clear secure storage
        await SecureStorageService().clear();

        context.goNamed(AppRouter.onBoarding);
      } else {
        bool isLoginKey = SharedPreferenceService().getBool(
          SharPrefConstants.isLoginKey,
        );

        if (isLoginKey) {
          context.goNamed(AppRouter.home);
        } else {
          context.goNamed(AppRouter.login);
        }
      }
      return;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value == 1.1 ? 1.1 : _scaleAnimation.value,
              child: Image.asset(AppIcons.logo, width: 256, height: 256),
            );
          },
        ),
      ),
    );
  }
}
