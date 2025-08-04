import 'package:flutter/material.dart';
import '../../data/constants/app_colors.dart';

enum ToastPosition { top, bottom, center }

enum PSize {
  text9,
  text12,
  text13,
  text14,
  text16,
  text18,
  text20,
  text24,
  text28,
  text30,
}

// enum PStyle { primary, secondary, tertiary, link }

enum MessageType { error, success, warning, info, route }

enum LoadingShape {
  wave,
  waveSpinner,
  ripple,
  pouringHourGlassRefined,
  spinningLines,
  foldingCube,
  cubeGrid,
  fadingCircle,
}

enum FlavorsTypes { prod, dev, stage, enterprise }

enum AppState { foregorund, background, terminated }

enum ShareTypes { textOnly, textAndImage }

enum CalendarType {
  halfYearHoliday,
  eidHoliday,
  endYearHoliday,
  activitiesInstitues,
  nationalDayHoliday,
  other,
}

extension MyCalendarType on CalendarType {
  static const Map<CalendarType, Color> colors = {
    CalendarType.activitiesInstitues: AppColors.activitiesColor,
    CalendarType.eidHoliday: AppColors.eidColor,
    CalendarType.halfYearHoliday: AppColors.halfYearColor,
    CalendarType.nationalDayHoliday: AppColors.nationalDayColor,
    CalendarType.endYearHoliday: AppColors.endYearColor,
    CalendarType.other: Colors.transparent,
  };

  Color get color => colors[this]!;
}

CalendarType getColorForEventType(int eventType) {
  switch (eventType) {
    case 1:
      return CalendarType.activitiesInstitues;
    case 2:
      return CalendarType.nationalDayHoliday;
    case 3:
      return CalendarType.eidHoliday;
    case 4:
      return CalendarType.halfYearHoliday;
    case 5:
      return CalendarType.endYearHoliday;
    case 6:
      return CalendarType.activitiesInstitues;
    default:
      return CalendarType.other;
  }
}

//upload type
// enum UploadType { image, file }

enum MyServicesEnum {
  exchangeRewards, // 1
  searchGuide, // 2
  identy_card, //3
  salaries, //4
  selfService, //5
  news, //6
  technical_support, //7
  documentReport, //8
  events, //9
  my_info, //10
  public_repair, //11
  communication_map, //12
  my_holidays, //13
  suggestion, //14
  query, //15
  myNotes, //16
  favourite, //17
  compliant, //18
}

enum MyFavouritNavigationScreenEnum {
  searchGuide,
  selfServices,
  myData,
  monthlySalaries,
  myHolidays,
  substitutions,
  myNotes,
  identityCard,
  map,
  documentReport,
  suggestion,
  compliant,
  query,
  news,
  activities,
  technicalSupport,
  generalmaintenance,
  favorite,
}

// TODO: all services
final List<Map<String, dynamic>> allServicesItems = [];
