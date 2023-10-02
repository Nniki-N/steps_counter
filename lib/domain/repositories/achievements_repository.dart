import 'package:steps_counter/domain/entities/account.dart';
import 'package:steps_counter/domain/entities/achivement.dart';
import 'package:steps_counter/common/errors/achievement_error.dart';

abstract class AchievementsRepository {
  /// Returns [Achievement] list from Database.
  ///
  /// Rethrows [AchievementErrorRetrievingAllAchievements] when any error occurs.
  Future<List<Achievement>> getAllAchievements();

  Stream<String> getAchievementsTrackStream({required Account account});
}
