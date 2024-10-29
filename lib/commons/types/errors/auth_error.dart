import 'package:lets_blog/commons/types/errors/app_error.dart';

class AuthError extends AppError {
  AuthError(super.message);
}

class InvalidCredentials extends AuthError {
  InvalidCredentials(super.message);
}

class UserAlreadyExists extends AuthError {
  UserAlreadyExists(super.message);
}

class UserNotFound extends AuthError {
  UserNotFound(super.message);
}

class UserPasswordMismatch extends AuthError {
  UserPasswordMismatch(super.message);
}

class AuthUnknownError extends AuthError {
  AuthUnknownError(super.message);
}
