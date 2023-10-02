import 'package:steps_counter/domain/entities/account.dart';
import 'package:steps_counter/common/errors/account_error.dart';

abstract class AccountRepository {
  AccountRepository();

  /// Retrieves an account data of the current user from Database
  /// and returns [Account] if request was successful.
  ///
  /// Rethrows [AccountError] when the error occurs.
  Future<Account> getCurrentAccount();

  /// Updates a user account data in Database.
  ///
  /// Rethrows [AccountError] when the error occurs.
  Future<void> updateUserAccount({required Account account});
}
