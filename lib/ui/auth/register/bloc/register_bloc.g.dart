// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_bloc.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RegisterStateCWProxy {
  RegisterState email(Validator<String, ValidatorError> email);

  RegisterState name(Validator<String, ValidatorError> name);

  RegisterState password(Validator<String, ValidatorError> password);

  RegisterState hidePassword(bool hidePassword);

  RegisterState isLoading(bool isLoading);

  RegisterState isRegisterSuccess(bool isRegisterSuccess);

  RegisterState error(AppError? error);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RegisterState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RegisterState(...).copyWith(id: 12, name: "My name")
  /// ````
  RegisterState call({
    Validator<String, ValidatorError>? email,
    Validator<String, ValidatorError>? name,
    Validator<String, ValidatorError>? password,
    bool? hidePassword,
    bool? isLoading,
    bool? isRegisterSuccess,
    AppError? error,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfRegisterState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfRegisterState.copyWith.fieldName(...)`
class _$RegisterStateCWProxyImpl implements _$RegisterStateCWProxy {
  const _$RegisterStateCWProxyImpl(this._value);

  final RegisterState _value;

  @override
  RegisterState email(Validator<String, ValidatorError> email) =>
      this(email: email);

  @override
  RegisterState name(Validator<String, ValidatorError> name) =>
      this(name: name);

  @override
  RegisterState password(Validator<String, ValidatorError> password) =>
      this(password: password);

  @override
  RegisterState hidePassword(bool hidePassword) =>
      this(hidePassword: hidePassword);

  @override
  RegisterState isLoading(bool isLoading) => this(isLoading: isLoading);

  @override
  RegisterState isRegisterSuccess(bool isRegisterSuccess) =>
      this(isRegisterSuccess: isRegisterSuccess);

  @override
  RegisterState error(AppError? error) => this(error: error);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RegisterState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RegisterState(...).copyWith(id: 12, name: "My name")
  /// ````
  RegisterState call({
    Object? email = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? password = const $CopyWithPlaceholder(),
    Object? hidePassword = const $CopyWithPlaceholder(),
    Object? isLoading = const $CopyWithPlaceholder(),
    Object? isRegisterSuccess = const $CopyWithPlaceholder(),
    Object? error = const $CopyWithPlaceholder(),
  }) {
    return RegisterState(
      email: email == const $CopyWithPlaceholder() || email == null
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as Validator<String, ValidatorError>,
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as Validator<String, ValidatorError>,
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
      isRegisterSuccess: isRegisterSuccess == const $CopyWithPlaceholder() ||
              isRegisterSuccess == null
          ? _value.isRegisterSuccess
          // ignore: cast_nullable_to_non_nullable
          : isRegisterSuccess as bool,
      error: error == const $CopyWithPlaceholder()
          ? _value.error
          // ignore: cast_nullable_to_non_nullable
          : error as AppError?,
    );
  }
}

extension $RegisterStateCopyWith on RegisterState {
  /// Returns a callable class that can be used as follows: `instanceOfRegisterState.copyWith(...)` or like so:`instanceOfRegisterState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RegisterStateCWProxy get copyWith => _$RegisterStateCWProxyImpl(this);
}
