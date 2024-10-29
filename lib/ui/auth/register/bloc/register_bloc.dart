import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:bloc/bloc.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:lets_blog/commons/const.dart';
import 'package:lets_blog/commons/types/errors/app_error.dart';
import 'package:lets_blog/commons/types/validators/app_validator.dart';
import 'package:lets_blog/commons/types/validators/validator.dart';
import 'package:lets_blog/domain/repositories/auth_repository.dart';

part 'register_bloc.g.dart';
part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const RegisterState()) {
    on<RegisterNameChanged>(_onNameChanged);
    on<RegisterPasswordChanged>(_onPasswordChanged);
    on<RegisterEmailChanged>(_onEmailChanged);
    on<RegisterTogglePasswordVisibility>((_, emit) {
      emit(state.copyWith(hidePassword: !state.hidePassword));
    });
    on<RegisterSubmitted>(_onSubmitted);
  }

  final AuthRepository _authRepository;

  void _onNameChanged(
    RegisterNameChanged event,
    Emitter<RegisterState> emit,
  ) {
    final name = event.name;
    emit(state.copyWith(name: DirtyValidator(name)));

    if (name.trim().isEmpty) {
      emit(
        state.copyWith(
          name: ErrorValidator(value: name, error: const ValueEmpty()),
        ),
      );
    }
  }

  void _onPasswordChanged(
    RegisterPasswordChanged event,
    Emitter<RegisterState> emit,
  ) {
    final password = event.password;
    emit(state.copyWith(password: DirtyValidator(password)));

    if (password.trim().isEmpty) {
      emit(
        state.copyWith(
          password: ErrorValidator(value: password, error: const ValueEmpty()),
        ),
      );
      return;
    }

    if (password.length < Constants.passwordMinLength) {
      emit(
        state.copyWith(
          password:
              ErrorValidator(value: password, error: const PasswordTooShort()),
        ),
      );
      return;
    }
  }

  void _onEmailChanged(
    RegisterEmailChanged event,
    Emitter<RegisterState> emit,
  ) {
    final email = event.email;
    emit(state.copyWith(email: DirtyValidator(email)));
    // value empty
    if (email.trim().isEmpty) {
      emit(
        state.copyWith(
          email: ErrorValidator(value: email, error: const ValueEmpty()),
        ),
      );
      return;
    }
    // email invalid format

    if (!email.isEmail) {
      emit(
        state.copyWith(
          email:
              ErrorValidator(value: email, error: const EmailInvalidFormat()),
        ),
      );
      return;
    }
  }

  Future<void> _onSubmitted(
    RegisterSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final registerResult = await _authRepository.register(
      email: state.email.value,
      password: state.password.value,
      name: state.name.value,
    );
    registerResult.fold(
      onSuccess: (_) {
        emit(state.copyWith(isLoading: false, isRegisterSuccess: true));
      },
      onError: (error) {
        emit(
          state.copyWith(
            isLoading: false,
            isRegisterSuccess: false,
            error: error,
          ),
        );
        onError(error, StackTrace.current);
      },
    );
  }
}
