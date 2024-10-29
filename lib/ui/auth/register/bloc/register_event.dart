part of 'register_bloc.dart';

class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterEmailChanged extends RegisterEvent {
  const RegisterEmailChanged(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

class RegisterNameChanged extends RegisterEvent {
  const RegisterNameChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

class RegisterPasswordChanged extends RegisterEvent {
  const RegisterPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

class RegisterSubmitted extends RegisterEvent {
  const RegisterSubmitted();
}

class RegisterTogglePasswordVisibility extends RegisterEvent {
  const RegisterTogglePasswordVisibility();
}
