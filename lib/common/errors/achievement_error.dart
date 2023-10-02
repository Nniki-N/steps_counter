/// The abstract error for the firebase auth exeption.
abstract class AchievementError {
  final String errorTitle;
  final String errorText;

  const AchievementError({
    required this.errorTitle,
    required this.errorText,
  });

  @override
  String toString() {
    return 'ErrorTitle: $errorTitle \nErrorText: $errorText';
  }
}

/// The [AchievementError] child for an unknown error.
class AchievementErrorUnknown extends AchievementError {
  const AchievementErrorUnknown({
    String? errorTitle,
    String? errorText,
  }) : super(
          errorTitle: errorTitle ?? 'Error',
          errorText: errorText ?? 'Unknown achievement error happened',
        );
}

/// The [AchievementError] child for retrieving all achievements.
class AchievementErrorRetrievingAllAchievements extends AchievementError {
  const AchievementErrorRetrievingAllAchievements()
      : super(
          errorTitle: 'Retrieving all achievements error',
          errorText: 'Something happened while retrieving all achievements',
        );
}

/// The [AchievementError] child for retrieving achievement.
class AchievementErrorRetrievingAchievement extends AchievementError {
  const AchievementErrorRetrievingAchievement()
      : super(
          errorTitle: 'Retrieving achievement error',
          errorText: 'Something happened while retrieving achievement',
        );
}