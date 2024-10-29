import 'dart:async';

import 'package:appwrite/models.dart';
import 'package:bloc/bloc.dart';
import 'package:lets_blog/domain/repositories/auth_repository.dart';
import 'package:meta/meta.dart';

part 'user_session_event.dart';
part 'user_session_state.dart';

class UserSessionBloc extends Bloc<UserSessionEvent, UserSessionState> {
  UserSessionBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(UserSessionInitial()) {
    on<UserSessionHandleAuthStateChanged>(_onAuthStateChanged);
    on<UserSessionCheckAuth>(_onCheckAuth);
    _userSubscription = _authRepository.user$.listen((user) {
      add(UserSessionHandleAuthStateChanged(user));
    });
    add(UserSessionCheckAuth());
  }

  final AuthRepository _authRepository;
  late final StreamSubscription<User?> _userSubscription;

  FutureOr<void> _onAuthStateChanged(
    UserSessionHandleAuthStateChanged event,
    Emitter<UserSessionState> emit,
  ) {
    final user = event.user;
    if (user != null) {
      emit(UserSessionAuthenticated(user));
    } else {
      emit(UserSessionUnauthenticated());
    }
  }

  Future<void> _onCheckAuth(
    UserSessionCheckAuth event,
    Emitter<UserSessionState> emit,
  ) async {
    final result = await _authRepository.checkAuth();
    result.withError((e) {
      onError(e, StackTrace.current);
    });
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
