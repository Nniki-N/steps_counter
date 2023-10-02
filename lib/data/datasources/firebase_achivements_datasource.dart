import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:steps_counter/common/constants/firebase_constants.dart';
import 'package:steps_counter/common/errors/achievement_error.dart';
import 'package:steps_counter/data/models/achievement_model.dart';

class FirebaseAchievementsDataSource {
  final FirebaseFirestore _firebaseFirestore;
  final Logger _logger;

  FirebaseAchievementsDataSource({
    required FirebaseFirestore firebaseFirestore,
    required Logger logger,
  })  : _firebaseFirestore = firebaseFirestore,
        _logger = logger;

  /// Returns [AchievementModel] list from Firebase Firestore.
  ///
  /// Throws [AchievementErrorRetrievingAllAchievements] when any error occurs.
  Future<List<AchievementModel>> getAllAchievements() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await _firebaseFirestore
              .collection(FirebaseConstants.achivements)
              .get();

      return snapshot.docs.map((doc) {
        return AchievementModel.fromJson(doc.data());
      }).toList();
    } catch (exception) {
      _logger.e(exception);
      throw const AchievementErrorRetrievingAllAchievements();
    }
  }

  // ///
  // ///
  // ///
  // Future<AchievementModel> getAchievementById({
  //   required String achievementId,
  // }) async {
  //   try {
  //     final DocumentSnapshot<Map<String, dynamic>> snapshot =
  //         await _firebaseFirestore
  //             .collection(FirebaseConstants.achivements)
  //             .doc(achievementId)
  //             .get();

  //     final Map<String, dynamic>? json = snapshot.data();

  //     if (json != null) return AchievementModel.fromJson(json);

  //     throw const AchievementErrorRetrievingAchievement();
  //   } catch (exception) {
  //     _logger.e(exception);
  //     throw const AchievementErrorRetrievingAchievement();
  //   }
  // }
}
