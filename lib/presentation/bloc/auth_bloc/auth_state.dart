import 'package:steps_counter/common/errors/auth_error.dart';

abstract class AuthState {
  final AuthError? error;

  const AuthState({
    this.error,
  });
}

class LoadingAuthState extends AuthState {
  const LoadingAuthState({
    AuthError? error,
  }) : super(
          error: error,
        );
}

class LoggedInAuthState extends AuthState {
  const LoggedInAuthState({
    AuthError? error,
  }) : super(
          error: error,
        );
}

class LoggedOutAuthState extends AuthState {
  const LoggedOutAuthState({
    AuthError? error,
  }) : super(
          error: error,
        );
}