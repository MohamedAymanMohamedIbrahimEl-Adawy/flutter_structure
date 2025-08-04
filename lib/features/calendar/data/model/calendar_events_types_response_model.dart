// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class CalendarEventsTypesResponseModel {
  List<CalendarEventsTypesModel>? model;

  CalendarEventsTypesResponseModel({
    this.model,
  });

  CalendarEventsTypesResponseModel copyWith({
    List<CalendarEventsTypesModel>? model,
  }) {
    return CalendarEventsTypesResponseModel(
      model: model ?? this.model,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'model': model?.map((x) => x.toMap()).toList(),
    };
  }

  CalendarEventsTypesResponseModel fromMap(Map<String, dynamic> map) {
    return CalendarEventsTypesResponseModel(
      model: map['model'] != null
          ? List<CalendarEventsTypesModel>.from(
        (map['model']).map<CalendarEventsTypesModel?>(
              (x) =>
              CalendarEventsTypesModel.fromMap(x as Map<String, dynamic>),
        ),
      )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  CalendarEventsTypesResponseModel fromJson(String source) =>
      fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CalendarEventsTypesResponseModel(model: $model)';

  @override
  bool operator ==(covariant CalendarEventsTypesResponseModel other) {
    if (identical(this, other)) return true;

    return listEquals(other.model, model);
  }

  @override
  int get hashCode => model.hashCode;
}

class CalendarEventsTypesModel {
  int? id;
  String? name;
  String? color;
  CalendarEventsTypesModel({
    this.id,
    this.name,
    this.color,
  });

  CalendarEventsTypesModel copyWith({
    int? id,
    String? name,
    String? color,
  }) {
    return CalendarEventsTypesModel(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'color': color,
    };
  }

  factory CalendarEventsTypesModel.fromMap(Map<String, dynamic> map) {
    return CalendarEventsTypesModel(
      id: map['id']??0,
      name: map['name'] != null ? map['name'] as String : null,
      color: map['color'] != null ? map['color'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CalendarEventsTypesModel.fromJson(String source) =>
      CalendarEventsTypesModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CalendarEventsTypesModel(id: $id, name: $name)';

  @override
  bool operator ==(covariant CalendarEventsTypesModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
