// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class CalendarViewResponseModel {
  List<CalendarData>? model;
  CalendarViewResponseModel({
    this.model,
  });

  CalendarViewResponseModel copyWith({
    List<CalendarData>? model,
  }) {
    return CalendarViewResponseModel(
      model: model ?? this.model,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'model': model?.map((x) => x.toMap()).toList(),
    };
  }

  CalendarViewResponseModel fromMap(Map<String, dynamic> map) {
    return CalendarViewResponseModel(
      model: map['model'] != null
          ? List<CalendarData>.from(
              (map['model']).map<CalendarData?>(
                (x) => CalendarData.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  CalendarViewResponseModel fromJson(String source) =>
      fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CalendarViewResponseModel(model: $model)';

  @override
  bool operator ==(covariant CalendarViewResponseModel other) {
    if (identical(this, other)) return true;

    return listEquals(other.model, model);
  }

  @override
  int get hashCode => model.hashCode;
}

class CalendarData {
  String? date;
  int? eventTypeId;
  dynamic eventType;
  CalendarData({
    this.date,
    this.eventTypeId,
    this.eventType,
  });

  CalendarData copyWith({
    String? date,
    int? eventTypeId,
    dynamic eventType,
  }) {
    return CalendarData(
      date: date ?? this.date,
      eventTypeId: eventTypeId ?? this.eventTypeId,
      eventType: eventType ?? this.eventType,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date,
      'eventTypeId': eventTypeId,
      'eventType': eventType,
    };
  }

  factory CalendarData.fromMap(Map<String, dynamic> map) {
    return CalendarData(
      date: map['date'] != null ? map['date'] as String : null,
      eventTypeId:
          map['eventTypeId'] != null ? map['eventTypeId'] as int : null,
      eventType: map['eventType'] as dynamic,
    );
  }

  String toJson() => json.encode(toMap());

  factory CalendarData.fromJson(String source) =>
      CalendarData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'CalendarData(date: $date, eventTypeId: $eventTypeId, eventType: $eventType)';

  @override
  bool operator ==(covariant CalendarData other) {
    if (identical(this, other)) return true;

    return other.date == date &&
        other.eventTypeId == eventTypeId &&
        other.eventType == eventType;
  }

  @override
  int get hashCode => date.hashCode ^ eventTypeId.hashCode ^ eventType.hashCode;
}
