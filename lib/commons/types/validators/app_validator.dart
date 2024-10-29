import 'package:lets_blog/commons/types/validators/validator.dart';

class EmailInvalidFormat extends ValidatorError {
  const EmailInvalidFormat() : super('Email is invalid');
}

class PasswordTooShort extends ValidatorError {
  const PasswordTooShort() : super('Password is too short');
}

class ValueEmpty extends ValidatorError {
  const ValueEmpty() : super('Value cannot be empty');
}

class NameTooShort extends ValidatorError {
  const NameTooShort() : super('Name is too short');
}
