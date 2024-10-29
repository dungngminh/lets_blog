import 'package:appwrite/appwrite.dart';
import 'package:lets_blog/commons/types/errors/auth_error.dart';

extension AppWriteAccountErrorMapper on AppwriteException {
  AuthError get authError {
    return switch (type) {
      'user_password_mismatch' => UserPasswordMismatch(message),
      'user_not_found' => UserNotFound(message),
      'user_already_exists' => UserAlreadyExists(message),
      'user_invalid_credentials' => InvalidCredentials(message),
      _ => AuthUnknownError(message),
    };
  }
}
