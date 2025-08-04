import 'package:dartz/dartz.dart';
import '../repository/calendar_repo.dart';

class CalendarUseCase {
  final CalendarRepository calendarRepository;

  CalendarUseCase({required this.calendarRepository});

  Future<Either> getCalendarView(
      {required int hijriYear, required int month}) async {
    return await calendarRepository.getCalendarView(
        hijriYear: hijriYear, month: month);
  }

  Future<Either> getCalendarEvents(
      {required int hijriYear,
      required int hijriMonth,
      required int day}) async {
    return await calendarRepository.getCalendarEvents(
        hijriYear: hijriYear, hijriMonth: hijriMonth, day: day);
  }
}
