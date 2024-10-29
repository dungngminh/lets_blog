part of 'user_session_bloc.dart';

@immutable
sealed class UserSessionEvent {}

final class UserSessionHandleAuthStateChanged extends UserSessionEvent {
  UserSessionHandleAuthStateChanged(this.user);

  final User? user;
}

final class UserSessionCheckAuth extends UserSessionEvent {}
