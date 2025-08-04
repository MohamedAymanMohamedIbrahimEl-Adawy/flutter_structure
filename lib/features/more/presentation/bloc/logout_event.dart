part of 'logout_bloc.dart';

abstract class LogoutEvent {
  const LogoutEvent();
}

class ActionLogoutEvent extends LogoutEvent {
  final BuildContext context;
  const ActionLogoutEvent(this.context) : super();
}

