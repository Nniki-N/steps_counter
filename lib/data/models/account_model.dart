import 'package:json_annotation/json_annotation.dart';
import 'package:steps_counter/data/models/shemas/account_schema.dart';
import 'package:steps_counter/domain/entities/account.dart';

part 'account_model.g.dart';

@JsonSerializable(explicitToJson: true)
class AccountModel {
  @JsonKey(name: AccountSchema.uid)
  final String uid;
  @JsonKey(name: AccountSchema.achievementUidList)
  final List<String> achievementUidList;

  AccountModel({
    required this.uid,
    required this.achievementUidList,
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) =>
      _$AccountModelFromJson(json);
  Map<String, dynamic> toJson() => _$AccountModelToJson(this);

  factory AccountModel.fromEntity({required Account account}) => AccountModel(
        uid: account.uid,
        achievementUidList: account.achievementUidList,
      );
}
