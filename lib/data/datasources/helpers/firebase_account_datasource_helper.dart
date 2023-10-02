import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:steps_counter/common/constants/firebase_constants.dart';
import 'package:steps_counter/common/errors/account_error.dart';
import 'package:steps_counter/data/models/account_model.dart';

class FirebaseAccountDatasourceHelper {
  final FirebaseFirestore _firebaseFirestore;
  final Logger _logger;

  const FirebaseAccountDatasourceHelper({
    required FirebaseFirestore firebaseFirestore,
    required Logger logger,
  })  : _firebaseFirestore = firebaseFirestore,
        _logger = logger;

  /// Creates a new account document in the Firestore Database.
  ///
  /// Throws [AccountErrorCreatingAccount] when the error occurs.
  Future<void> createAccount({required AccountModel accountModel}) async {
    try {
      await _firebaseFirestore
          .collection(FirebaseConstants.accounts)
          .doc(accountModel.uid)
          .set(accountModel.toJson());
    } catch (exception) {
      _logger.e(exception);
      throw const AccountErrorCreatingAccount();
    }
  }

  /// Retrieves a user account data from the Firestore Database and returns
  /// [AccountModel] if the request was successful.
  ///
  /// Throws [AccountErrorRetrievingAccount] if an account data was not retrieved.
  /// Throws [AccountErrorCreatingAccount] when other error occurs.
  Future<AccountModel> getAccountModel({required String uid}) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> snapshot =
          await _firebaseFirestore
              .collection(FirebaseConstants.accounts)
              .doc(uid)
              .get();

      final Map<String, dynamic>? json = snapshot.data();

      if (json == null) throw const AccountErrorRetrievingAccount();

      return AccountModel.fromJson(json);
    } catch (exception) {
      _logger.e(exception);
      throw const AccountErrorRetrievingAccount();
    }
  }

  /// Updates a user account data in the Firestore Database.
  ///
  /// Throws [AccountErrorUpdatingAccount] when the error occurs.
  Future<void> updateAccount({required AccountModel accountModel}) async {
    try {
      await _firebaseFirestore
          .collection(FirebaseConstants.accounts)
          .doc(accountModel.uid)
          .update(accountModel.toJson());
    } catch (exception) {
      _logger.e(exception);
      throw const AccountErrorUpdatingAccount();
    }
  }
}
