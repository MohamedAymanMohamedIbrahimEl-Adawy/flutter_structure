import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:cleanarchitecture/core/services/base_network/client/dio_client.dart';
import 'package:cleanarchitecture/core/services/base_network/network_lost/network_info.dart';
import 'package:cleanarchitecture/features/calendar/data/repository/calendar_repository_impl.dart';
import 'package:cleanarchitecture/features/calendar/domain/repository/calendar_repo.dart';
import 'package:cleanarchitecture/features/calendar/domain/use_case/calendar_use_case.dart';
import 'package:cleanarchitecture/features/communication_map/data/repository/map_repository_impl.dart';
import 'package:cleanarchitecture/features/communication_map/domain/repository/map_repo.dart';
import 'package:cleanarchitecture/features/communication_map/domain/use_case/map_use_case.dart';
import 'package:cleanarchitecture/features/login/data/repository/login_repository_impl.dart';
import 'package:cleanarchitecture/features/login/domain/repository/login_repo.dart';
import 'package:cleanarchitecture/features/login/domain/use_case/login_use_case.dart';
import 'package:cleanarchitecture/features/more/data/repository/logout_repository_impl.dart';
import 'package:cleanarchitecture/features/more/domain/repository/logout_repo.dart';
import 'package:cleanarchitecture/features/more/domain/use_case/logout_use_case.dart';
import 'core/services/flavorizer/flavors_managment.dart';
import 'core/services/local_storage/shared_preference/shared_preference_service.dart';
import 'features/calendar/domain/use_case/calendar_events_types_use_case.dart';
import 'features/home/data/repo/home_repository_impl.dart';
import 'features/home/domain/repo/home_repository.dart';
import 'features/home/domain/usecase/home_usecase.dart';

final GetIt getIt = GetIt.instance;

class AppDependencies {
  Future<void> initialize() async {
    // Future.delayed(Duration(seconds: 3,), () {
    //     FlutterNativeSplash.remove();
    //   },
    // );
    // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

    await Future.wait([
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]),
      // Init localization
      EasyLocalization.ensureInitialized(),
      // Init Firebase
      Firebase.initializeApp(),

      // Load dotenv file
      dotenv.load(fileName: 'api_end_points.env'),

      // Init shared preference
      SharedPreferenceService().init(),
    ]);

    // Init flavors must be init but after load dotenv file
    // so we can use base url form the file
    FlavorsManagement.instance.init();

    //bloc

    // Use cases
    getIt.registerLazySingleton<LoginUseCase>(
      () => LoginUseCase(loginRepository: getIt()),
    );
    getIt.registerLazySingleton<HomeUseCase>(
      () => HomeUseCase(homeRepository: getIt()),
    );
    getIt.registerLazySingleton<CalendarUseCase>(
      () => CalendarUseCase(calendarRepository: getIt()),
    );
    getIt.registerLazySingleton<LogoutUseCase>(
      () => LogoutUseCase(logoutRepository: getIt()),
    );

    getIt.registerLazySingleton<MapUseCase>(() => MapUseCase(mapRepo: getIt()));

    getIt.registerLazySingleton<CalendarEventsTypesUseCase>(
      () => CalendarEventsTypesUseCase(calendarRepository: getIt()),
    );

    // Repositories
    getIt.registerLazySingleton<LoginRepository>(
      () => LoginRepositoryImpl(networkInfo: getIt(), remoteData: getIt()),
    );
    getIt.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(networkInfo: getIt(), remoteData: getIt()),
    );
    getIt.registerLazySingleton<CalendarRepository>(
      () => CalendarRepositoryImpl(networkInfo: getIt(), remoteData: getIt()),
    );
    getIt.registerLazySingleton<LogoutRepository>(
      () => LogoutRepositoryImpl(networkInfo: getIt(), remoteData: getIt()),
    );

    // Core
    getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(getIt()));

    getIt.registerLazySingleton<MapRepo>(
      () => MapRepositoryImpl(networkInfo: getIt(), remoteData: getIt()),
    );

    getIt.registerSingleton(DioClient());

    await getIt<DioClient>().updateHeader();

    // getIt.registerLazySingleton<LocalData>(() => LocalData(getIt()));

    getIt.registerLazySingleton(
      () => InternetConnectionChecker.createInstance(),
    );
  }
}
