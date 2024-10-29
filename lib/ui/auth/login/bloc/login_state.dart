part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.email = const PureValidator(''),
    this.password = const PureValidator(''),
    this.isLoading = false,
    this.error,
  });
  final Validator<String, ValidatorError> email;
  final Validator<String, ValidatorError> password;
  final bool isLoading;
  final AppError? error;

  @override
  List<Object?> get props => [email, password, isLoading, error];

  LoginState copyWith({
    Validator<String, ValidatorError>? email,
    Validator<String, ValidatorError>? password,
    bool? isLoading,
    AppError? error,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  bool get isFormValid => Validator.validate([email, password]);

  bool get isError => error != null;
}

class EmailInvalidFormat extends ValidatorError {
  EmailInvalidFormat() : super('Email is invalid');
}

class PasswordTooShort extends ValidatorError {
  PasswordTooShort() : super('Password is too short');
}

class ValueEmpty extends ValidatorError {
  ValueEmpty() : super('Value cannot be empty');
}
