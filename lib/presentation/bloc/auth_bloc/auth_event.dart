abstract class AuthEvent {
  const AuthEvent();
}

class InitializeAuthEvent extends AuthEvent {
  const InitializeAuthEvent();
}

class SignInAuthEvent extends AuthEvent {
  final String email;
  final String password;

  const SignInAuthEvent({
    required this.email,
    required this.password,
  });
}

class RegisterAuthEvent extends AuthEvent {
  final String email;
  final String password;

  const RegisterAuthEvent({
    required this.email,
    required this.password,
  });
}

class LogOutAuthEvent extends AuthEvent {
  const LogOutAuthEvent();
}
