part of 'user_session_bloc.dart';

@immutable
sealed class UserSessionState {}

final class UserSessionInitial extends UserSessionState {}

final class UserSessionAuthenticated extends UserSessionState {
  UserSessionAuthenticated(this.user);

  final User user;
}

final class UserSessionUnauthenticated extends UserSessionState {}
