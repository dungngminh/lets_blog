import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lets_blog/commons/const.dart';
import 'package:lets_blog/commons/types/errors/app_error.dart';
import 'package:lets_blog/commons/types/validator.dart';
import 'package:lets_blog/domain/repositories/auth_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(const LoginState()) {
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
  }

  final AuthRepository _authRepository;

  void _onEmailChanged(
    LoginEmailChanged event,
    Emitter<LoginState> emit,
  ) {
    final email = event.email;
    emit(state.copyWith(email: DirtyValidator(email)));
    // value empty
    if (email.trim().isEmpty) {
      emit(
        state.copyWith(
          email: ErrorValidator(value: email, error: ValueEmpty()),
        ),
      );
      return;
    }
    // email invalid format

    if (!email.isEmail) {
      emit(
        state.copyWith(
          email: ErrorValidator(value: email, error: EmailInvalidFormat()),
        ),
      );
      return;
    }
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final password = event.password;
    emit(state.copyWith(password: DirtyValidator(password)));

    // value empty
    if (password.trim().isEmpty) {
      emit(
        state.copyWith(
          password: ErrorValidator(value: password, error: ValueEmpty()),
        ),
      );
      return;
    }

    // password too short

    if (password.length < Constants.passwordMinLength) {
      emit(
        state.copyWith(
          password: ErrorValidator(value: password, error: PasswordTooShort()),
        ),
      );
      return;
    }
  }

  Future<void> _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final loginResult = await _authRepository.login(
      email: state.email.value,
      password: state.password.value,
    );
    loginResult.fold(
      onSuccess: (_) => emit(state.copyWith(isLoading: false)),
      onError: (error) => emit(state.copyWith(isLoading: false, error: error)),
    );
  }
}
