
import 'package:steps_counter/data/models/account_model.dart';

class Account {
  final String uid;
  final List<String> achievementUidList;

  Account({
    required this.uid,
    required this.achievementUidList,
  });

  factory Account.fromModel({required AccountModel accountModel}) => Account(
        uid: accountModel.uid,
        achievementUidList: accountModel.achievementUidList,
      );

  Account copyWith({
    String? uid,
    List<String>? achievementUidList,
  }) {
    return Account(
      uid: uid ?? this.uid,
      achievementUidList: achievementUidList ?? this.achievementUidList,
    );
  }
}
