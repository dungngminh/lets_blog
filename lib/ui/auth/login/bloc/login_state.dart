part of 'login_bloc.dart';

@CopyWith()
class LoginState extends Equatable {
  const LoginState({
    this.email = const PureValidator(''),
    this.password = const PureValidator(''),
    this.hidePassword = true,
    this.isLoading = false,
    this.error,
  });
  final Validator<String, ValidatorError> email;
  final Validator<String, ValidatorError> password;
  final bool hidePassword;
  final bool isLoading;
  final AppError? error;

  @override
  List<Object?> get props {
    return [
      email,
      password,
      hidePassword,
      isLoading,
      error,
    ];
  }

  bool get isFormValid => Validator.validate([email, password]);

  bool get isError => error != null;
}
