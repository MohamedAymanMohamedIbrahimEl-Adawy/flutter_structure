import 'package:dartz/dartz.dart';
import 'package:cleanarchitecture/core/services/base_network/api_endpoints_constants.dart';
import 'package:cleanarchitecture/core/services/base_network/network_repository.dart';
import 'package:cleanarchitecture/features/calendar/data/model/calendar_events_response_model.dart';
import 'package:cleanarchitecture/features/calendar/data/model/calendar_view_response_model.dart';
import 'package:cleanarchitecture/features/calendar/domain/repository/calendar_repo.dart';

import '../../../../core/services/base_network/general_response_model.dart';
import '../model/calendar_events_types_response_model.dart';

class CalendarRepositoryImpl extends MainRepository
    implements CalendarRepository {
  CalendarRepositoryImpl({
    required super.remoteData,
    required super.networkInfo, // For checking network connection
  });

  @override
  Future<Either> getCalendarEvents({
    required int hijriYear,
    required int hijriMonth,
    required int day,
  }) async {
    final result = await remoteData.get(
      endPoint:
          '${ApiEndpointsConstants.calendarEvents}?hijriYear=$hijriYear&hijriMonth=$hijriMonth&day=$day',
      // path: '${ApiEndpointsConstants.calendarEvents}?hijriYear=$date',
      headers: headers,
      model: GeneralResponseModel(model: CalendarEventsResponseModel()),
    );
    return result;
  }

  @override
  Future<Either> getCalendarEventsTypes() async {
    final result = await remoteData.get(
      endPoint: ApiEndpointsConstants.calendarEventsTypes,
      headers: headers,
      model: GeneralResponseModel(model: CalendarEventsTypesResponseModel()),
    );
    return result;
  }

  @override
  Future<Either> getCalendarView({
    required int hijriYear,
    required int month,
  }) async {
    final result = await remoteData.get(
      endPoint:
          '${ApiEndpointsConstants.calendarView}?hijriYear=$hijriYear&hijriMonth=$month',
      headers: headers,
      model: GeneralResponseModel(model: CalendarViewResponseModel()),
    );
    return result;
  }
}
