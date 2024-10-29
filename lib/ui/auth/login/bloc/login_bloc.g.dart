// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_bloc.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$LoginStateCWProxy {
  LoginState email(Validator<String, ValidatorError> email);

  LoginState password(Validator<String, ValidatorError> password);

  LoginState hidePassword(bool hidePassword);

  LoginState isLoading(bool isLoading);

  LoginState error(AppError? error);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `LoginState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// LoginState(...).copyWith(id: 12, name: "My name")
  /// ````
  LoginState call({
    Validator<String, ValidatorError>? email,
    Validator<String, ValidatorError>? password,
    bool? hidePassword,
    bool? isLoading,
    AppError? error,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfLoginState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfLoginState.copyWith.fieldName(...)`
class _$LoginStateCWProxyImpl implements _$LoginStateCWProxy {
  const _$LoginStateCWProxyImpl(this._value);

  final LoginState _value;

  @override
  LoginState email(Validator<String, ValidatorError> email) =>
      this(email: email);

  @override
  LoginState password(Validator<String, ValidatorError> password) =>
      this(password: password);

  @override
  LoginState hidePassword(bool hidePassword) =>
      this(hidePassword: hidePassword);

  @override
  LoginState isLoading(bool isLoading) => this(isLoading: isLoading);

  @override
  LoginState error(AppError? error) => this(error: error);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `LoginState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// LoginState(...).copyWith(id: 12, name: "My name")
  /// ````
  LoginState call({
    Object? email = const $CopyWithPlaceholder(),
    Object? password = const $CopyWithPlaceholder(),
    Object? hidePassword = const $CopyWithPlaceholder(),
    Object? isLoading = const $CopyWithPlaceholder(),
    Object? error = const $CopyWithPlaceholder(),
  }) {
    return LoginState(
      email: email == const $CopyWithPlaceholder() || email == null
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as Validator<String, ValidatorError>,
      password: password == const $CopyWithPlaceholder() || password == null
          ? _value.password
          // ignore: cast_nullable_to_non_nullable
          : password as Validator<String, ValidatorError>,
      hidePassword:
          hidePassword == const $CopyWithPlaceholder() || hidePassword == null
              ? _value.hidePassword
              // ignore: cast_nullable_to_non_nullable
              : hidePassword as bool,
      isLoading: isLoading == const $CopyWithPlaceholder() || isLoading == null
          ? _value.isLoading
          // ignore: cast_nullable_to_non_nullable
          : isLoading as bool,
      error: error == const $CopyWithPlaceholder()
          ? _value.error
          // ignore: cast_nullable_to_non_nullable
          : error as AppError?,
    );
  }
}

extension $LoginStateCopyWith on LoginState {
  /// Returns a callable class that can be used as follows: `instanceOfLoginState.copyWith(...)` or like so:`instanceOfLoginState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$LoginStateCWProxy get copyWith => _$LoginStateCWProxyImpl(this);
}
