// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'achievement_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AchievementModel _$AchievementModelFromJson(Map<String, dynamic> json) =>
    AchievementModel(
      achivementId: json['achivementId'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      imageLink: json['imageLink'] as String,
    );

Map<String, dynamic> _$AchievementModelToJson(AchievementModel instance) =>
    <String, dynamic>{
      'achivementId': instance.achivementId,
      'title': instance.title,
      'description': instance.description,
      'imageLink': instance.imageLink,
    };
