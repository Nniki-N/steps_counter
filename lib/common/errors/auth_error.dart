
import 'package:firebase_auth/firebase_auth.dart';

/// Map of all child errors of type [AuthError].
const Map<String, AuthError> firebaseAuthErrorsMapping = {
  'user-not-found': AuthErrorUserNotFound(),
  'no-current-user': AuthErrorNoCurrentUser(),
  'requires-recent-login': AuthErrorRequiresRecentLogin(),
  'weak-password': AuthErrorWeakPassword(),
  'invalid-email': AuthErrorInvalidEmail(),
  'invalid-password': AuthErrorInvalidPassword(),
  'email-already-in-use': AuthErrorEmailAlreadyInUse(),
  'wrong-password': AuthErrorWrongPassword(),
  'account-exists-with-different-credential':
      AuthErrorAccountExistsWithDifferentCredential(),
  'invalid-credential': AuthErrorInvalidCredential(),
  'credential-already-in-use': AuthErrorCredentialAlreadyInUse(),
};

/// The abstract error for the firebase auth exeption.
///
/// Factory constructor implements conversion of [FirebaseAuthException]
/// in [AuthError]
abstract class AuthError {
  final String errorTitle;
  final String errorText;

  const AuthError({
    required this.errorTitle,
    required this.errorText,
  });

  factory AuthError.fromFirebaseAuthExeption({
    required FirebaseAuthException exception,
  }) =>
      firebaseAuthErrorsMapping[exception.code.toLowerCase().trim()] ??
      const AuthErrorUnknown();

  @override
  String toString() {
    return 'ErrorTitle: $errorTitle \nErrorText: $errorText';
  }
}

/// The [AuthError] child for an unknown error.
class AuthErrorUnknown extends AuthError {
  const AuthErrorUnknown({
    String? errorTitle,
    String? errorText,
  }) : super(
          errorTitle: errorTitle ?? 'Error',
          errorText: errorText ?? 'Unknown auth error happened',
        );
}

/// The [AuthError] child for a firebase error "auth/user-not-found".
class AuthErrorUserNotFound extends AuthError {
  const AuthErrorUserNotFound()
      : super(
          errorTitle: 'User not found',
          errorText: 'The user with given credentials was not found',
        );
}

/// The [AuthError] child for a firebase error "auth/no-current-user".
class AuthErrorNoCurrentUser extends AuthError {
  const AuthErrorNoCurrentUser()
      : super(
          errorTitle: 'No current user',
          errorText: 'No current user with this information was found',
        );
}

/// The [AuthError] child for a firebase error "auth/requires-recent-login".
class AuthErrorRequiresRecentLogin extends AuthError {
  const AuthErrorRequiresRecentLogin()
      : super(
          errorTitle: 'Requires recent login',
          errorText:
              'You need to log out and log back in again in order to perform this operation',
        );
}

/// The [AuthError] child for a firebase error "auth/invalid-email".
class AuthErrorInvalidEmail extends AuthError {
  const AuthErrorInvalidEmail()
      : super(
          errorTitle: 'Invalid email',
          errorText: 'Please double check your email and try again',
        );
}

/// The [AuthError] child for a firebase error "auth/invalid-password".
class AuthErrorInvalidPassword extends AuthError {
  const AuthErrorInvalidPassword()
      : super(
          errorTitle: 'Invalid password',
          errorText: 'Please try again',
        );
}

/// The [AuthError] child for a firebase error "auth/weak-password".
class AuthErrorWeakPassword extends AuthError {
  const AuthErrorWeakPassword()
      : super(
          errorTitle: 'Weak password',
          errorText:
              'Please choose a stronger password consisting of more characters',
        );
}

/// The [AuthError] child for a firebase error "auth/wrong-password".
class AuthErrorWrongPassword extends AuthError {
  const AuthErrorWrongPassword()
      : super(
          errorTitle: 'Wrong password',
          errorText: 'The password is invalid for the given email',
        );
}

/// The [AuthError] child for a firebase error "auth/email-already-in-use".
class AuthErrorEmailAlreadyInUse extends AuthError {
  const AuthErrorEmailAlreadyInUse()
      : super(
          errorTitle: 'Email already in use',
          errorText: 'Please choose another email to register with',
        );
}

/// The [AuthError] child for a firebase error "auth/account-exists-with-different-credential".
class AuthErrorAccountExistsWithDifferentCredential extends AuthError {
  const AuthErrorAccountExistsWithDifferentCredential()
      : super(
          errorTitle: 'Invalid email',
          errorText: 'An account with this email address already exists',
        );
}

/// The [AuthError] child for a firebase error "auth/invalid-credential".
class AuthErrorInvalidCredential extends AuthError {
  const AuthErrorInvalidCredential()
      : super(
          errorTitle: 'Invalid credential',
          errorText: 'The credential is malformed or has expired',
        );
}

/// The [AuthError] child for a firebase error "auth/credential-already-in-use".
class AuthErrorCredentialAlreadyInUse extends AuthError {
  const AuthErrorCredentialAlreadyInUse()
      : super(
          errorTitle: 'Invalid credential',
          errorText: 'The credential is already in use',
        );
}

/// The [AuthError] child for a registration error.
class AuthErrorRegistration extends AuthError {
  const AuthErrorRegistration({
    String? errorTitle,
    String? errorText,
  }) : super(
          errorTitle: errorTitle ?? 'Registration error',
          errorText: errorText ?? 'Something happened while registration',
        );
}