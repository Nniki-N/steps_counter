import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steps_counter/common/errors/achievement_error.dart';
import 'package:steps_counter/domain/entities/achivement.dart';
import 'package:steps_counter/domain/repositories/achievements_repository.dart';
import 'package:steps_counter/presentation/bloc/achievements_bloc/achievements_event.dart';
import 'package:steps_counter/presentation/bloc/achievements_bloc/achievements_state.dart';

class AchievementsBloc extends Bloc<AchievementsEvent, AchievementsState> {
  final AchievementsRepository _achievementsRepository;

  AchievementsBloc({
    required AchievementsRepository achievementsRepository,
  })  : _achievementsRepository = achievementsRepository,
        super(const InitialAchievementsState()) {
    //
    on<InitializeAchievementsEvent>(_init);
    // on<TrackForNewAchievementsEvent>(_trackForNewAchievements);
  }

  /// Initializes all achievements.
  Future<void> _init(
    InitializeAchievementsEvent event,
    Emitter<AchievementsState> emit,
  ) async {
    try {
      emit(LoadingAchievementsState(achievements: state.achievements));

      final List<Achievement> allAchievements =
          await _achievementsRepository.getAllAchievements();

      emit(LoadedAchievementsState(achievements: allAchievements));
    } on AchievementError catch (exception) {
      emit(
        ErrorAchievementsState(
          achievements: state.achievements,
          errorTitle: exception.errorTitle,
          errorText: exception.errorText,
        ),
      );
    }
  }

  // Future<void> _trackForNewAchievements(
  //   TrackForNewAchievementsEvent event,
  //   Emitter<AchievementsState> emit,
  // ) async {
  //   try {
  //     ///
  //     ///
  //     ///
  //     ///
  //     ///
  //     ///
  //     ///
  //   } on AchievementError catch (exception) {
  //     emit(
  //       ErrorAchievementsState(
  //         achievements: state.achievements,
  //         errorTitle: exception.errorTitle,
  //         errorText: exception.errorText,
  //       ),
  //     );
  //   }
  // }
}
