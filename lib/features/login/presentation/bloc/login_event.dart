part of 'login_bloc.dart';

abstract class LoginEvent {
  const LoginEvent();
}

class NormalLoginEvent extends LoginEvent {
  final bool saveLogin;
  final LoginRequestModel loginRequestModel;
  const NormalLoginEvent({
    required this.loginRequestModel,
    required this.saveLogin,
  }) : super();
}

class BiomatricLoginEvent extends LoginEvent {
  const BiomatricLoginEvent() : super();
}

class ValidationEvent extends LoginEvent {
  final LoginRequestModel loginRequestModel;
  const ValidationEvent({
    required this.loginRequestModel,
  }) : super();
}

class EnableBiometricEvent extends LoginEvent {
  const EnableBiometricEvent() : super();
}
