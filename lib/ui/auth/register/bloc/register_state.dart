part of 'register_bloc.dart';

@CopyWith()
class RegisterState extends Equatable {
  const RegisterState({
    this.email = const PureValidator(''),
    this.name = const PureValidator(''),
    this.password = const PureValidator(''),
    this.hidePassword = true,
    this.isLoading = false,
    this.isRegisterSuccess = false,
    this.error,
  });
  final Validator<String, ValidatorError> email;
  final Validator<String, ValidatorError> name;
  final Validator<String, ValidatorError> password;
  final bool hidePassword;
  final bool isLoading;
  final bool isRegisterSuccess;
  final AppError? error;

  @override
  List<Object?> get props {
    return [
      email,
      name,
      password,
      hidePassword,
      isRegisterSuccess,
      isLoading,
      error,
    ];
  }

  bool get isFormValid => Validator.validate([email, name, password]);

  bool get isError => error != null;
}
