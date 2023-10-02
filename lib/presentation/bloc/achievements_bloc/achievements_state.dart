import 'package:steps_counter/domain/entities/achivement.dart';

abstract class AchievementsState {
  final List<Achievement> achievements;

  const AchievementsState({
    required this.achievements,
  });
}

class InitialAchievementsState extends AchievementsState {
  const InitialAchievementsState({
    List<Achievement> achievements = const [],
  }) : super(achievements: achievements);
}

class LoadingAchievementsState extends AchievementsState {
  const LoadingAchievementsState({
    required List<Achievement> achievements,
  }) : super(achievements: achievements);
}

class LoadedAchievementsState extends AchievementsState {
  const LoadedAchievementsState({
    required List<Achievement> achievements,
  }) : super(achievements: achievements);
}

class ErrorAchievementsState extends AchievementsState {
  final String errorTitle;
  final String errorText;

  const ErrorAchievementsState({
    required List<Achievement> achievements,
    required this.errorTitle,
    required this.errorText,
  }) : super(achievements: achievements);
}
