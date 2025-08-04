// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class CalendarEventsResponseModel {
  List<CalendarEventsData>? model;

  CalendarEventsResponseModel({
    this.model,
  });

  CalendarEventsResponseModel copyWith({
    List<CalendarEventsData>? model,
  }) {
    return CalendarEventsResponseModel(
      model: model ?? this.model,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'model': model?.map((x) => x.toMap()).toList(),
    };
  }

  CalendarEventsResponseModel fromMap(Map<String, dynamic> map) {
    return CalendarEventsResponseModel(
      model: map['model'] != null
          ? List<CalendarEventsData>.from(
              (map['model']).map<CalendarEventsData?>(
                (x) => CalendarEventsData.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  CalendarEventsResponseModel fromJson(String source) =>
      fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CalendarEventsResponseModel(model: $model)';

  @override
  bool operator ==(covariant CalendarEventsResponseModel other) {
    if (identical(this, other)) return true;

    return listEquals(other.model, model);
  }

  @override
  int get hashCode => model.hashCode;
}

class CalendarEventsData {
  String? title;
  String? description;
  String? date;
  int? eventTypeId;
  dynamic eventType;
  String? attachmentUrl;
  String? location;

  CalendarEventsData({
    this.title,
    this.description,
    this.date,
    this.eventTypeId,
    this.eventType,
    this.attachmentUrl,
    this.location = "",
  });

  CalendarEventsData copyWith({
    String? title,
    String? description,
    String? date,
    int? eventTypeId,
    dynamic eventType,
    String? attachmentUrl,
    String? location,
  }) {
    return CalendarEventsData(
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      eventTypeId: eventTypeId ?? this.eventTypeId,
      eventType: eventType ?? this.eventType,
      attachmentUrl: attachmentUrl ?? this.attachmentUrl,
      location: location ?? this.location,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'date': date,
      'eventTypeId': eventTypeId,
      'eventType': eventType,
      'attachmentUrl': attachmentUrl,
      'location': location,
    };
  }

  factory CalendarEventsData.fromMap(Map<String, dynamic> map) {
    return CalendarEventsData(
      title: map['title'] != null ? map['title'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      date: map['date'] != null ? map['date'] as String : null,
      eventTypeId:
          map['eventTypeId'] != null ? map['eventTypeId'] as int : null,
      eventType: map['eventType'] != null ? map['eventType'] as dynamic : null,
      attachmentUrl:
          map['attachmentUrl'] != null ? map['attachmentUrl'] as String : null,
      location: map['location'] != null ? map['location'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CalendarEventsData.fromJson(String source) =>
      CalendarEventsData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CalendarEventsData(title: $title, description: $description, date: $date, eventTypeId: $eventTypeId, eventType: $eventType, attachmentUrl: $attachmentUrl, location: $location)';
  }

  @override
  bool operator ==(covariant CalendarEventsData other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.description == description &&
        other.date == date &&
        other.eventTypeId == eventTypeId &&
        other.eventType == eventType &&
        other.attachmentUrl == attachmentUrl &&
        other.location == location;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        description.hashCode ^
        date.hashCode ^
        eventTypeId.hashCode ^
        eventType.hashCode ^
        attachmentUrl.hashCode ^
        location.hashCode;
  }
}
