import 'dart:convert';
import 'package:flutter/foundation.dart';

class GeneralResponseModel {
  dynamic model;
  bool? success;
  String? message;
  List<Errors>? errors;
  int? statusCode;
  GeneralResponseModel({
    this.model,
    this.success,
    this.message,
    this.errors,
    this.statusCode,
  });

  GeneralResponseModel copyWith({
    dynamic model,
    bool? success,
    String? message,
    List<Errors>? errors,
    int? statusCode,
  }) {
    return GeneralResponseModel(
      model: model ?? this.model,
      success: success ?? this.success,
      message: message ?? this.message,
      errors: errors ?? this.errors,
      statusCode: statusCode ?? this.statusCode,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'model': model,
      'success': success,
      'message': message,
      'errors': errors?.map((x) => x.toMap()).toList(),
      'statusCode': statusCode,
    };
  }

  GeneralResponseModel fromMap(Map<String, dynamic> map) {
    return GeneralResponseModel(
      model:map['model'] is bool? true : (map['model'] == null ? null : model.fromMap(map)),
      success: map['success'] != null ? map['success'] as bool : null,
      message: map['message'] != null ? map['message'] as String : null,
      errors: map['errors'] != null
          ? List<Errors>.from(
              (map['errors']).map<Errors?>(
                (x) => Errors().fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      statusCode: map['statusCode'] != null ? map['statusCode'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  GeneralResponseModel fromJson(String source) =>
      fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GeneralResponseModel(model: $model, success: $success, message: $message, errors: $errors, statusCode: $statusCode)';
  }

  @override
  bool operator ==(covariant GeneralResponseModel other) {
    if (identical(this, other)) return true;

    return other.model == model &&
        other.success == success &&
        other.message == message &&
        listEquals(other.errors, errors) &&
        other.statusCode == statusCode;
  }

  @override
  int get hashCode {
    return model.hashCode ^
        success.hashCode ^
        message.hashCode ^
        errors.hashCode ^
        statusCode.hashCode;
  }
}

class Errors {
  String? errorCode;
  String? message;

  Errors({
    this.errorCode,
    this.message,
  });

  Errors copyWith({
    String? errorCode,
    String? message,
  }) {
    return Errors(
      errorCode: errorCode ?? this.errorCode,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'errorCode': errorCode,
      'message': message,
    };
  }

  Errors fromMap(Map<String, dynamic> map) {
    return Errors(
      errorCode: map['errorCode'] != null ? map['errorCode'] as String : null,
      message: map['message'] != null ? map['message'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  Errors fromJson(String source) =>
      fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Errors(errorCode: $errorCode, message: $message)';

  @override
  bool operator ==(covariant Errors other) {
    if (identical(this, other)) return true;

    return other.errorCode == errorCode && other.message == message;
  }

  @override
  int get hashCode => errorCode.hashCode ^ message.hashCode;
}
