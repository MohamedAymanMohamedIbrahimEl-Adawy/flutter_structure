import 'package:dartz/dartz.dart';

abstract class CalendarRepository {
  Future<Either<dynamic, dynamic>> getCalendarView(
      {required int hijriYear, required int month});

  Future<Either<dynamic, dynamic>> getCalendarEvents({
    required int hijriYear,
    required int hijriMonth,
    required int day,
  });

  Future<Either<dynamic, dynamic>> getCalendarEventsTypes();
}
