import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:steps_counter/common/errors/auth_error.dart';
import 'package:steps_counter/data/datasources/firebase_auth_datasource.dart';
import 'package:steps_counter/domain/repositories/auth_repository.dart';

class FirebaseAuthRepository implements AuthRepository {
  final FirebaseAuthDataSource _authDatasource;

  FirebaseAuthRepository({
    required FirebaseAuthDataSource authDatasource,
  }) : _authDatasource = authDatasource;

  /// Logs the user in the app with email and password.
  ///
  /// Throws [AuthError] when the error of type [FirebaseAuthException] occurs.
  @override
  Future<void> signInWithEmailAndPasseord({
    required String email,
    required String password,
  }) async {
    try {
      await _authDatasource.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (firebaseAuthException) {
      throw AuthError.fromFirebaseAuthExeption(
        exception: firebaseAuthException,
      );
    } catch (exception) {
      rethrow;
    }
  }

  /// Registers the user with email, password, username and login.
  ///
  /// Throws [AuthError] when the error of type [FirebaseAuthException] occurs.
  @override
  Future<void> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _authDatasource.registerWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (firebaseAuthException) {
      throw AuthError.fromFirebaseAuthExeption(
        exception: firebaseAuthException,
      );
    } catch (exception) {
      rethrow;
    }
  }

  /// Logs the user out from the app.
  ///
  /// Throws [AuthError] when the error of type [FirebaseAuthException] occurs.
  /// Throws [AuthErrorUnknown] when the error of type [PlatformException] occurs.
  @override
  Future<void> logOut() async {
    try {
      await _authDatasource.logOut();
    } on FirebaseAuthException catch (firebaseAuthException) {
      throw AuthError.fromFirebaseAuthExeption(
        exception: firebaseAuthException,
      );
    } on PlatformException {
      throw const AuthErrorUnknown();
    }
  }

  /// Checks if the user is logged in.
  @override
  Future<bool> isLoggedIn() async => _authDatasource.isLoggedIn();
}
