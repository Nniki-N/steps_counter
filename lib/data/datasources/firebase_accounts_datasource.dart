
import 'package:firebase_auth/firebase_auth.dart';
import 'package:steps_counter/common/errors/account_error.dart';
import 'package:steps_counter/data/datasources/helpers/firebase_account_datasource_helper.dart';
import 'package:steps_counter/data/models/account_model.dart';

class FirebaseAccountsDataSource {
  final FirebaseAccountDatasourceHelper _firebaseAccountDatasourceHelper;
  final FirebaseAuth _firebaseAuth;

  FirebaseAccountsDataSource({
    required FirebaseAuth firebaseAuth,
    required FirebaseAccountDatasourceHelper firebaseAccountDatasourceHelper,
  })  : _firebaseAuth = firebaseAuth,
        _firebaseAccountDatasourceHelper = firebaseAccountDatasourceHelper;

  /// Retrieves an account data of the current user from the Firestore Database and returns
  /// [AccountModel] if the request was successful.
  ///
  /// Throws [AccountErrorRetrievingAccount] if a [User] retrieving from local
  /// Firebase Database failed.
  ///
  /// Rethrows [AccountError] when the error occurs.
  Future<AccountModel> getCurrentAccountModel() async {
    try {
      final User? user = _firebaseAuth.currentUser;

      if (user == null) throw const AccountErrorRetrievingAccount();

      final AccountModel accountModel =
          await _firebaseAccountDatasourceHelper.getAccountModel(
        uid: user.uid,
      );

      return accountModel;
    } catch (exception) {
      rethrow;
    }
  }

  /// Updates a user account data in the Firestore Database.
  ///
  /// Rethrows [AccountError] when the error occurs.
  Future<void> updateAccount({required AccountModel accountModel}) async {
    try {
      await _firebaseAccountDatasourceHelper.updateAccount(
        accountModel: accountModel,
      );
    } catch (exception) {
      rethrow;
    }
  }
}
