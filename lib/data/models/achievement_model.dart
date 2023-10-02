import 'package:json_annotation/json_annotation.dart';
import 'package:steps_counter/data/models/achievement_schema.dart';

part 'achievement_model.g.dart';

@JsonSerializable(explicitToJson: true)
class AchievementModel {
  @JsonKey(name: AchievementSchema.achivementId)
  final String achivementId;
  @JsonKey(name: AchievementSchema.title)
  final String title;
  @JsonKey(name: AchievementSchema.description)
  final String description;
  @JsonKey(name: AchievementSchema.imageLink)
  final String imageLink;

  AchievementModel({
    required this.achivementId,
    required this.title,
    required this.description,
    required this.imageLink,
  });

  factory AchievementModel.fromJson(Map<String, dynamic> json) =>
      _$AchievementModelFromJson(json);
  Map<String, dynamic> toJson() => _$AchievementModelToJson(this);
}
