import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:steps_counter/common/errors/auth_error.dart';
import 'package:steps_counter/data/datasources/helpers/firebase_account_datasource_helper.dart';
import 'package:steps_counter/data/models/account_model.dart';

class FirebaseAuthDataSource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseAccountDatasourceHelper _firebaseAccountDatasourceHelper;
  final Logger _logger;

  FirebaseAuthDataSource({
    required FirebaseAuth firebaseAuth,
    required FirebaseAccountDatasourceHelper firebaseAccountDatasourceHelper,
    required Logger logger,
  })  : _firebaseAuth = firebaseAuth,
        _firebaseAccountDatasourceHelper = firebaseAccountDatasourceHelper,
        _logger = logger;

  /// Logs the user in the app via Firebase Authentication with email and password.
  ///
  /// Throws [AuthErrorUserNotFound] if a login process failed.
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;

      // Throws an error if a login process in the Firebase failed.
      if (user == null) throw const AuthErrorUserNotFound();
    } catch (exception) {
      _logger.e(exception);
      rethrow;
    }
  }

  /// Registers a user with email, password in the Firebase.
  /// 
  /// Creates an account document in the Firebase Firestore.
  ///
  /// Throws [AuthErrorRegistration] if a registration process failed.
  Future<void> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? user = userCredential.user;

      // Throws an error if a registration process in the Firebase failed.
      if (user == null) throw const AuthErrorRegistration();

      final AccountModel accountModel = AccountModel(
        uid: user.uid,
        achievementUidList: ['1'],
      );

      // Creates a user account.
      await _firebaseAccountDatasourceHelper.createAccount(accountModel: accountModel);
    } catch (exception) {
      _logger.e(exception);
      rethrow;
    }
  }

  /// Logs the user out from the app.
  Future<void> logOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (exception) {
      _logger.e(exception);
      rethrow;
    }
  }

  /// Checks if user is logged in.
  bool isLoggedIn() => _firebaseAuth.currentUser == null ? false : true;
}
