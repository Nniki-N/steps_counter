import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steps_counter/common/errors/auth_error.dart';
import 'package:steps_counter/domain/repositories/auth_repository.dart';
import 'package:steps_counter/presentation/bloc/auth_bloc/auth_event.dart';
import 'package:steps_counter/presentation/bloc/auth_bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(const LoadingAuthState()) {
    on<InitializeAuthEvent>(_init);
    on<SignInAuthEvent>(signIn);
    on<RegisterAuthEvent>(register);
    on<LogOutAuthEvent>(logOut);
  }

  /// Checks if user is logged in and sets first state.
  ///
  /// Sets the error to the state if [AuthError] occurs.
  Future<void> _init(InitializeAuthEvent event, Emitter<AuthState> emit) async {
    try {
      emit(const LoadingAuthState());

      final bool isLoggedIn = await _authRepository.isLoggedIn();

      if (isLoggedIn) {
        emit(const LoggedInAuthState());
      } else {
        emit(const LoggedOutAuthState());
      }
    } on AuthError catch (authError) {
      emit(LoggedOutAuthState(error: authError));
    }
  }

  Future<void> signIn(SignInAuthEvent event, Emitter<AuthState> emit) async {
    try {
      emit(const LoadingAuthState());

      await _authRepository.signInWithEmailAndPasseord(
        email: event.email,
        password: event.password,
      );

      final bool isLoggedIn = await _authRepository.isLoggedIn();

      if (isLoggedIn) {
        emit(const LoggedInAuthState());
      } else {
        emit(const LoggedOutAuthState());
      }
    } on AuthError catch (authError) {
      emit(LoggedOutAuthState(error: authError));
    }
  }

  Future<void> register(
      RegisterAuthEvent event, Emitter<AuthState> emit) async {
    try {
      emit(const LoadingAuthState());

      await _authRepository.registerWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      emit(const LoggedInAuthState());
    } on AuthError catch (authError) {
      emit(LoggedOutAuthState(error: authError));
    }
  }

  Future<void> logOut(LogOutAuthEvent event, Emitter<AuthState> emit) async {
    try {
      emit(const LoadingAuthState());

      await _authRepository.logOut();

      emit(const LoggedOutAuthState());
    } on AuthError catch (authError) {
      emit(LoggedOutAuthState(error: authError));
    }
  }
}
