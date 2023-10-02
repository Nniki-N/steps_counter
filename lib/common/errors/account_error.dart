abstract class AccountError {
  final String errorTitle;
  final String errorText;

  const AccountError({
    required this.errorTitle,
    required this.errorText,
  });

  @override
  String toString() {
    return 'ErrorTitle: $errorTitle \nErrorText: $errorText';
  }
}

/// The [AccountError] child for an unknown error.
class AccountErrorUnknown extends AccountError {
  const AccountErrorUnknown({
    String? errorTitle,
    String? errorText,
  }) : super(
          errorTitle: errorTitle ?? 'Error',
          errorText: errorText ?? 'Unknown account error happened',
        );
}

/// The [AccountError] child for a creating account error.
class AccountErrorCreatingAccount extends AccountError {
  const AccountErrorCreatingAccount()
      : super(
          errorTitle: 'Unable to create an account',
          errorText: 'Some error happened while creating an account',
        );
}

/// The [AccountError] child for a retrieving account error.
class AccountErrorRetrievingAccount extends AccountError {
  const AccountErrorRetrievingAccount()
      : super(
          errorTitle: 'Unable to retrieve an account',
          errorText: 'Some error happened while retrieving an account',
        );
}

/// The [AccountError] child for an updating account error.
class AccountErrorUpdatingAccount extends AccountError {
  const AccountErrorUpdatingAccount()
      : super(
          errorTitle: 'Unable to update the account',
          errorText: 'Some error happened while updating the account',
        );
}