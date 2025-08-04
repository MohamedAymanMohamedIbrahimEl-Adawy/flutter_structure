import 'package:dartz/dartz.dart';
import '../repository/calendar_repo.dart';

class CalendarEventsTypesUseCase {
  final CalendarRepository calendarRepository;

  CalendarEventsTypesUseCase({
    required this.calendarRepository,
  });

  Future<Either> getCalendarEventsTypes() async {
    return await calendarRepository.getCalendarEventsTypes();
  }
}
