import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:steps_counter/common/constants/shared_preferences_constants.dart';
import 'package:steps_counter/common/errors/auth_error.dart';
import 'package:steps_counter/data/datasources/firebase_accounts_datasource.dart';
import 'package:steps_counter/data/datasources/firebase_auth_datasource.dart';
import 'package:steps_counter/data/models/account_model.dart';
import 'package:steps_counter/domain/repositories/auth_repository.dart';

class FirebaseAuthRepository implements AuthRepository {
  final FirebaseAuthDataSource _firebaseAuthDataSource;
  final FirebaseAccountsDataSource _firebaseAccountsDataSource;
  final SharedPreferences _sharedPreferences;

  FirebaseAuthRepository({
    required FirebaseAuthDataSource firebaseAuthDataSource,
    required FirebaseAccountsDataSource firebaseAccountsDataSource,
    required SharedPreferences sharedPreferences,
  })  : _firebaseAuthDataSource = firebaseAuthDataSource,
        _firebaseAccountsDataSource = firebaseAccountsDataSource,
        _sharedPreferences = sharedPreferences;

  /// Logs the user in the app with email and password.
  ///
  /// Throws [AuthError] when the error of type [FirebaseAuthException] occurs.
  @override
  Future<void> signInWithEmailAndPasseord({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuthDataSource.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final AccountModel accountModel = await _firebaseAccountsDataSource.getCurrentAccountModel();

      await _sharedPreferences.setStringList(
        SharedPreferencesConstants.userAchievementsListKey(uid: accountModel.uid),
        accountModel.achievementUidList,
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
      await _firebaseAuthDataSource.registerWithEmailAndPassword(
        email: email,
        password: password,
      );

      final AccountModel accountModel = await _firebaseAccountsDataSource.getCurrentAccountModel();

      await _sharedPreferences.setStringList(
        SharedPreferencesConstants.userAchievementsListKey(uid: accountModel.uid),
        ['1'],
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
      await _firebaseAuthDataSource.logOut();
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
  Future<bool> isLoggedIn() async => _firebaseAuthDataSource.isLoggedIn();
}
