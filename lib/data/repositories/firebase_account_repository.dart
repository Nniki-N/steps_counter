import 'package:steps_counter/data/datasources/firebase_accounts_datasource.dart';
import 'package:steps_counter/data/models/account_model.dart';
import 'package:steps_counter/domain/entities/account.dart';
import 'package:steps_counter/domain/repositories/account_repository.dart';
import 'package:steps_counter/common/errors/account_error.dart';

class FirebaseAccountRepository implements AccountRepository {
  final FirebaseAccountsDataSource _firebaseAccountsDataSource;

  FirebaseAccountRepository({
    required FirebaseAccountsDataSource firebaseAccountsDataSource,
  }) : _firebaseAccountsDataSource = firebaseAccountsDataSource;

  /// Retrieves an account data of the current user from the Firestore Database
  /// and returns [Account] if request was successful.
  ///
  /// Rethrows [AccountError] when the error occurs.
  @override
  Future<Account> getCurrentAccount() async {
    try {
      final AccountModel accountModel =
          await _firebaseAccountsDataSource.getCurrentAccountModel();

      final Account account = Account.fromModel(
        accountModel: accountModel,
      );

      return account;
    } catch (exception) {
      rethrow;
    }
  }

  /// Updates a user account data in the Firestore Database.
  ///
  /// Rethrows [AccountError] when the error occurs.
  @override
  Future<void> updateUserAccount({required Account account}) async {
    try {
      final AccountModel accountModel = AccountModel.fromEntity(
        account: account,
      );
      await _firebaseAccountsDataSource.updateAccount(
        accountModel: accountModel,
      );
    } catch (exception) {
      rethrow;
    }
  }
}
