import 'package:steps_counter/data/datasources/firebase_achivements_datasource.dart';
import 'package:steps_counter/data/models/achievement_model.dart';
import 'package:steps_counter/domain/entities/achivement.dart';
import 'package:steps_counter/domain/repositories/achievements_repository.dart';
import 'package:steps_counter/common/errors/achievement_error.dart';

class FirebaseAchievementsRepository implements AchievementsRepository {
  final FirebaseAchievementsDataSource _firebaseAchievementsDataSource;

  FirebaseAchievementsRepository({
    required FirebaseAchievementsDataSource firebaseAchievementsDataSource,
  }) : _firebaseAchievementsDataSource = firebaseAchievementsDataSource;

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
}
