class SharedPreferencesConstants {
  static String userAchievementsListKey({required String uid}) =>
      achievementsListKey + uid;
  static const String achievementsListKey = 'achievementsListKey';
  static const String todayNumberOfStepskey = 'todayNumberOfStepskey';
  static const String lastNumberOfStepsKey = 'lastNumberOfStepsKey';
  static const String lastNumberOfStepsDateKey = 'lastNumberOfStepsDateKey';
}
