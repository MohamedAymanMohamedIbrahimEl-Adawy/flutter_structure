import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class LogoutResponseModel {
  dynamic model;
  LogoutResponseModel({
    this.model,
  });

  LogoutResponseModel copyWith({
    dynamic model,
  }) {
    return LogoutResponseModel(
      model: model ?? this.model,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'model': model,
    };
  }

  LogoutResponseModel fromMap(Map<String, dynamic> map) {
    return LogoutResponseModel(
      model:map['model'] ,
    );
  }

  String toJson() => json.encode(toMap());

  LogoutResponseModel fromJson(String source) =>
      fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'LogoutResponseModel(model: $model)';

  @override
  bool operator ==(covariant LogoutResponseModel other) {
    if (identical(this, other)) return true;

    return other.model == model;
  }

  @override
  int get hashCode => model.hashCode;
}
