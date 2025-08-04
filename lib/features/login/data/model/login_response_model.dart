// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LoginResponseModel {
  LoginModel? model;
  LoginResponseModel({
    this.model,
  });

  LoginResponseModel copyWith({
    LoginModel? model,
  }) {
    return LoginResponseModel(
      model: model ?? this.model,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'model': model?.toMap(),
    };
  }

  LoginResponseModel fromMap(Map<String, dynamic> map) {
    return LoginResponseModel(
      model: map['model'] != null
          ? LoginModel.fromMap(map['model'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  LoginResponseModel fromJson(String source) =>
      fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'LoginResponseModel(model: $model)';

  @override
  bool operator ==(covariant LoginResponseModel other) {
    if (identical(this, other)) return true;

    return other.model == model;
  }

  @override
  int get hashCode => model.hashCode;
}

class LoginModel {
  String? token;
  String? refershToken;

  LoginModel({
    this.token,
    this.refershToken,
  });

  LoginModel copyWith({
    String? token,
    String? refershToken,
  }) {
    return LoginModel(
      token: token ?? this.token,
      refershToken: refershToken ?? this.refershToken,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
      'refershToken': refershToken,
    };
  }

  factory LoginModel.fromMap(Map<String, dynamic> map) {
    return LoginModel(
      token: map['token'] != null ? map['token'] as String : null,
      refershToken:
          map['refershToken'] != null ? map['refershToken'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginModel.fromJson(String source) =>
      LoginModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'LoginModel(token: $token, refershToken: $refershToken)';

  @override
  bool operator ==(covariant LoginModel other) {
    if (identical(this, other)) return true;

    return other.token == token && other.refershToken == refershToken;
  }

  @override
  int get hashCode => token.hashCode ^ refershToken.hashCode;
}
