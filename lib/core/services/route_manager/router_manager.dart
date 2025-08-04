import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cleanarchitecture/core/services/base_network/interceptors/request_interceptor.dart';
import 'package:cleanarchitecture/core/services/base_network/network_lost/widget/network_lost_widget.dart';
import 'package:cleanarchitecture/core/component/inspector/inspector_screen.dart';
import 'package:cleanarchitecture/core/data/constants/app_router.dart';
import 'package:cleanarchitecture/core/data/constants/global_obj.dart';
import 'package:cleanarchitecture/features/Splash/presentation/ui/splash_screen.dart';
import 'package:cleanarchitecture/features/calendar/presentation/ui/page/calendar_screen.dart';
import 'package:cleanarchitecture/features/communication_map/presentation/ui/communication_map_screen.dart';
import 'package:cleanarchitecture/features/login/presentation/ui/pages/login_screen.dart';
import 'package:cleanarchitecture/features/onboard/presentation/ui/pages/onboard_screen.dart';
import 'package:cleanarchitecture/features/parent/presentation/ui/page/parent_screen.dart';

import '../../../features/home/presentation/view/screen/main_screen.dart';
import '../../../features/more/presentation/view/screen/main_screen.dart';
import '../../../features/profile/presentation/view/screen/main_screen.dart';
import 'logging_observer.dart';

class RouterManager {
  static final GoRouter routerManager = GoRouter(
    initialLocation: AppRouter.splash,
    observers: [RouteAwareObserver(), LoggingObserver()],
    debugLogDiagnostics: true,
    navigatorKey: navigatorKey,
    routes: [
      GoRoute(
        name: AppRouter.inspector,
        path: AppRouter.inspector,
        builder:
            (context, state) => InspectorScreen(inspectorList: inspectList),
      ),
      GoRoute(
        name: AppRouter.splash,
        path: AppRouter.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        name: AppRouter.onBoarding,
        path: AppRouter.onBoarding,
        builder: (context, state) => const OnboardScreen(),
      ),
      GoRoute(
        name: AppRouter.login,
        path: AppRouter.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        name: AppRouter.noInternet,
        path: AppRouter.noInternet,
        builder: (context, state) => NetworkErrorPage(onRetry: () {}),
      ),

      GoRoute(
        name: AppRouter.communicationMapScreen,
        path: AppRouter.communicationMapScreen,
        builder: (context, state) => const CommunicationMapScreen(),
      ),

      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ParentScreen(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: AppRouter.home,
                path: AppRouter.home,
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: AppRouter.calendar,
                path: AppRouter.calendar,
                builder: (context, state) => const CalendarScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: AppRouter.profile,
                path: AppRouter.profile,
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: AppRouter.more,
                path: AppRouter.more,
                builder: (context, state) => const MoreScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );

  GoRouter get router => routerManager;
}

class RouteAwareObserver extends NavigatorObserver {
  final RouteObserver<ModalRoute<dynamic>> routeObserver =
      RouteObserver<ModalRoute<dynamic>>();

  void _logRouteChange(String action, Route route, Route? previousRoute) {
    final currentName = route.settings.name ?? 'Unknown';
    final previousName = previousRoute?.settings.name ?? 'None';

    debugPrint(
      '[ROUTE] $action → Current: $currentName | Previous: $previousName',
    );
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    _logRouteChange('PUSH', route, previousRoute);
    if (route is ModalRoute) {
      routeObserver.didPush(route, previousRoute as ModalRoute?);
    }
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    _logRouteChange(
      'POP',
      previousRoute ?? const RouteSettings(name: 'None') as Route,
      route,
    );
    if (route is ModalRoute) {
      routeObserver.didPop(route, previousRoute as ModalRoute?);
    }
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    _logRouteChange(
      'REPLACE',
      newRoute ?? const RouteSettings(name: 'Unknown') as Route,
      oldRoute,
    );
    if (newRoute is ModalRoute) {
      routeObserver.didReplace(
        newRoute: newRoute,
        oldRoute: oldRoute as ModalRoute?,
      );
    }
  }
}

PageRouteBuilder createZoomPageRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return ScaleTransition(
        scale: Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
        child: child,
      );
    },
  );
}
