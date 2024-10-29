import 'dart:async';
import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:injectable/injectable.dart';
import 'package:lets_blog/commons/types/errors/auth_error.dart';
import 'package:lets_blog/data/mappers/auth_mapper.dart';
import 'package:lets_blog/domain/repositories/auth_repository.dart';
import 'package:result_monad/result_monad.dart';

@Singleton(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  AuthRepositoryImpl({required Account account}) : _account = account;

  final Account _account;

  final _user$ = StreamController<User?>();

  @override
  Stream<User?> get user$ async* {
    // unAuthenticated
    yield null;
    // yield controller
    yield* _user$.stream;
  }

  @override
  Future<Result<User, AuthError>> login({
    required String email,
    required String password,
  }) {
    return _account
        .createEmailPasswordSession(email: email, password: password)
        .then<Result<User, AuthError>>((value) async {
      final user = await _account.get();
      _user$.add(user);
      return Result.ok(user);
    }).onError<AppwriteException>(
      (error, stackTrace) {
        return Result.error(error.authError);
      },
    );
  }

  @override
  Future<Result<void, AuthError>> register({
    required String email,
    required String password,
  }) {
    return _account
        .create(email: email, password: password, userId: ID.unique())
        .then<Result<void, AuthError>>((value) => Result.ok(null))
        .onError<AppwriteException>(
          (error, stackTrace) => Result.error(error.authError),
        );
  }

  @override
  Future<void> logout() {
    _user$.add(null);
    return _account.deleteSession(sessionId: 'current');
  }

  @override
  Future<Result<User, AuthError>> checkAuth() {
    return _account.get().then<Result<User, AuthError>>((user) {
      _user$.add(user);
      return Result.ok(user);
    }).onError<AppwriteException>(
      (error, stackTrace) {
        log(error.type.toString());
        return Result.error(error.authError);
      },
    );
  }
}
