import 'package:steps_counter/common/errors/auth_error.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  /// Logs the user in the app with email and password.
  ///
  /// Throws [AuthError] when the error of type [FirebaseAuthException] occurs.
  Future<void> signInWithEmailAndPasseord({
    required String email,
    required String password,
  });

  /// Registers the user with email, password, username and login.
  ///
  /// Throws [AuthError] when the error of type [FirebaseAuthException] occurs.
  Future<void> registerWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// Logs the user out from the app.
  ///
  /// Throws [AuthError] when the error of type [FirebaseAuthException] occurs.
  /// Throws [AuthErrorUnknown] when the error of type [PlatformException] occurs.
  Future<void> logOut();

  /// Checks if the user is logged in.
  Future<bool> isLoggedIn();
}
