import 'package:appwrite/models.dart';
import 'package:lets_blog/commons/types/errors/auth_error.dart';
import 'package:result_monad/result_monad.dart';

abstract class AuthRepository {
  Stream<User?> get user$;

  Future<Result<User, AuthError>> checkAuth();

  Future<Result<User, AuthError>> login({
    required String email,
    required String password,
  });

  Future<Result<void, AuthError>> register({
    required String email,
    required String password,
  });

  Future<void> logout();
}
