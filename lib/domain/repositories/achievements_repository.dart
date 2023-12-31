import 'package:steps_counter/domain/entities/achivement.dart';
import 'package:steps_counter/common/errors/achievement_error.dart';

abstract class AchievementsRepository {
  /// Returns [Achievement] list from Database.
  ///
  /// Rethrows [AchievementErrorRetrievingAllAchievements] when any error occurs.
  Future<List<Achievement>> getAllAchievements();

  /// Returns Stream of user achieved achievement ids.
  ///
  /// Rethrows any arror thar occurs.
  Stream<String> getAchievementsTrackStream();
}
