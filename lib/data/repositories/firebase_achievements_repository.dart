import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:steps_counter/common/constants/shared_preferences_constants.dart';
import 'package:steps_counter/data/datasources/firebase_achivements_datasource.dart';
import 'package:steps_counter/data/models/achievement_model.dart';
import 'package:steps_counter/domain/entities/account.dart';
import 'package:steps_counter/domain/entities/achivement.dart';
import 'package:steps_counter/domain/repositories/achievements_repository.dart';
import 'package:steps_counter/common/errors/achievement_error.dart';

class FirebaseAchievementsRepository implements AchievementsRepository {
  final FirebaseAchievementsDataSource _firebaseAchievementsDataSource;
  final SharedPreferences _sharedPreferences;

  FirebaseAchievementsRepository({
    required FirebaseAchievementsDataSource firebaseAchievementsDataSource,
    required SharedPreferences sharedPreferences,
  })  : _sharedPreferences = sharedPreferences,
        _firebaseAchievementsDataSource = firebaseAchievementsDataSource;

  /// Returns [Achievement] list from Firebase Firestore.
  ///
  /// Rethrows [AchievementErrorRetrievingAllAchievements] when any error occurs.
  @override
  Future<List<Achievement>> getAllAchievements() async {
    try {
      final List<AchievementModel> allAchievements =
          await _firebaseAchievementsDataSource.getAllAchievements();

      return allAchievements.map((achievementModel) {
        return Achievement.fromModel(achievementModel: achievementModel);
      }).toList();
    } catch (exception) {
      rethrow;
    }
  }

  /// Returns Stream of user achieved achievement ids.
  ///
  /// Rethrows any arror thar occurs.
  @override
  Stream<String> getAchievementsTrackStream({required Account account}) {
    try {
      // Stream of user achieved achievement ids.
      final StreamController<String> achievementsStreamController =
          StreamController<String>();
      final Stream<String> achievementsStream =
          achievementsStreamController.stream.asBroadcastStream();

      // Checks for new achievement every tick
      Timer.periodic(
        const Duration(milliseconds: 500),
        (timer) {
          _checkNumberOfStepsAchievements(
            achievementsStreamController: achievementsStreamController,
            account: account,
          );
        },
      );

      return achievementsStream;
    } catch (exception) {
      rethrow;
    }
  }

  /// Checks if user achieved any achievement.
  ///
  /// Currently only two achievements are available:
  /// 1. User reached 30 steps in one day.
  /// 2. User reached 100 steps  in one day.
  void _checkNumberOfStepsAchievements({
    required StreamController<String> achievementsStreamController,
    required Account account,
  }) {
    int? todayNumberOfStepskey = _sharedPreferences.getInt(
      SharedPreferencesConstants.todayNumberOfStepskey,
    );

    todayNumberOfStepskey ??= 0;

    if (todayNumberOfStepskey >= 30 && !account.achievementUidList.contains('2')) {
      achievementsStreamController.add('2');
    }

    if (todayNumberOfStepskey >= 100 && !account.achievementUidList.contains('3')) {
      achievementsStreamController.add('3');
    }
  }
}
