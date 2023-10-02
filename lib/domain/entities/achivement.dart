// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:steps_counter/data/models/achievement_model.dart';

class Achievement {
  final String achivementId;
  final String title;
  final String description;
  final String imageLink;
  final bool isAchieved;

  Achievement({
    required this.achivementId,
    required this.title,
    required this.description,
    required this.imageLink,
    required this.isAchieved,
  });

  factory Achievement.fromModel({required AchievementModel achievementModel}) =>
      Achievement(
        achivementId: achievementModel.achivementId,
        title: achievementModel.title,
        description: achievementModel.description,
        imageLink: achievementModel.imageLink,
        isAchieved: false,
      );

  Achievement copyWith({
    String? achivementId,
    String? title,
    String? description,
    String? imageLink,
    bool? isAchieved,
  }) {
    return Achievement(
      achivementId: achivementId ?? this.achivementId,
      title: title ?? this.title,
      description: description ?? this.description,
      imageLink: imageLink ?? this.imageLink,
      isAchieved: isAchieved ?? this.isAchieved,
    );
  }
}
