import 'dart:convert';

class LoginRequestModel {
  String? userName;
  String? password;
  String? deviceToken;
  String? deviceID;
  LoginRequestModel({
    this.userName,
    this.password,
    this.deviceToken,
    this.deviceID,
  });

  LoginRequestModel copyWith({
    String? userName,
    String? password,
    String? deviceToken,
    String? deviceID,
  }) {
    return LoginRequestModel(
      userName: userName ?? this.userName,
      password: password ?? this.password,
      deviceToken: deviceToken ?? this.deviceToken,
      deviceID: deviceID ?? this.deviceID,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userName': userName,
      'password': password,
      'deviceToken': deviceToken,
      'deviceName': deviceID,
    };
  }

  factory LoginRequestModel.fromMap(Map<String, dynamic> map) {
    return LoginRequestModel(
      userName: map['userName'] != null ? map['userName'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      deviceToken:
          map['deviceToken'] != null ? map['deviceToken'] as String : null,
      deviceID: map['deviceName'] != null ? map['deviceName'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginRequestModel.fromJson(String source) =>
      LoginRequestModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'LoginRequestModel(userName: $userName, password: $password ,deviceToken: $deviceToken)';

  @override
  bool operator ==(covariant LoginRequestModel other) {
    if (identical(this, other)) return true;

    return other.userName == userName &&
        other.password == password &&
        other.deviceToken == deviceToken;
  }

  @override
  int get hashCode =>
      userName.hashCode ^ password.hashCode ^ deviceToken.hashCode;
}
