import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steps_counter/common/errors/account_error.dart';
import 'package:steps_counter/common/errors/achievement_error.dart';
import 'package:steps_counter/domain/entities/account.dart';
import 'package:steps_counter/domain/entities/achivement.dart';
import 'package:steps_counter/domain/repositories/account_repository.dart';
import 'package:steps_counter/domain/repositories/achievements_repository.dart';
import 'package:steps_counter/presentation/bloc/achievements_bloc/achievements_event.dart';
import 'package:steps_counter/presentation/bloc/achievements_bloc/achievements_state.dart';

class AchievementsBloc extends Bloc<AchievementsEvent, AchievementsState> {
  final AchievementsRepository _achievementsRepository;
  final AccountRepository _accountRepository;

  late StreamSubscription _streamSubscription;

  AchievementsBloc({
    required AchievementsRepository achievementsRepository,
    required AccountRepository accountRepository,
  })  : _achievementsRepository = achievementsRepository,
        _accountRepository = accountRepository,
        super(const InitialAchievementsState()) {
    on<InitializeAchievementsEvent>(_init);
    on<TrackForNewAchievementsEvent>(_trackForNewAchievements);
  }

  /// Initializes all achievements.
  Future<void> _init(
    InitializeAchievementsEvent event,
    Emitter<AchievementsState> emit,
  ) async {
    try {
      emit(LoadingAchievementsState(achievements: state.achievements));

      List<Achievement> allAchievements =
          await _achievementsRepository.getAllAchievements();

      final Account account = await _accountRepository.getCurrentAccount();

      // Filters for achieved achievements.
      allAchievements = allAchievements.map((achievement) {
        if (account.achievementUidList.contains(achievement.achivementId)) {
          return achievement.copyWith(isAchieved: true);
        }

        return achievement;
      }).toList();

      emit(LoadedAchievementsState(achievements: allAchievements));
    } on AchievementError catch (exception) {
      emit(
        ErrorAchievementsState(
          achievements: state.achievements,
          errorTitle: exception.errorTitle,
          errorText: exception.errorText,
        ),
      );
    } on AccountError catch (accountException) {
      emit(
        ErrorAchievementsState(
          achievements: state.achievements,
          errorTitle: accountException.errorTitle,
          errorText: accountException.errorText,
        ),
      );
    }
  }

  /// Tracks if user got new achievement.
  Future<void> _trackForNewAchievements(
    TrackForNewAchievementsEvent event,
    Emitter<AchievementsState> emit,
  ) async {
    try {
      // Stream of the current user achieved achievement ids.
      final Stream<String> achievementsStream =
          _achievementsRepository.getAchievementsTrackStream();

      await _listenStream(
        achievementsStream,
        onData: (achievementId) async {
          // Retrieves the account again as it may be updated.
          Account currentAccount = await _accountRepository.getCurrentAccount();
          List<String> achievementUidList = currentAccount.achievementUidList;

          achievementUidList.add(achievementId);

          currentAccount = currentAccount.copyWith(
            achievementUidList: achievementUidList,
          );

          // Saves an achievements change in the database.
          await _accountRepository.updateUserAccount(account: currentAccount);

          // Filters for achieved achieves.
          List<Achievement> allAchievements =
              state.achievements.map((achievement) {
            if (currentAccount.achievementUidList
                .contains(achievement.achivementId)) {
              return achievement.copyWith(isAchieved: true);
            }

            return achievement;
          }).toList();

          emit(LoadedAchievementsState(achievements: allAchievements));
        },
        onError: (error, stackTrace) {
          emit(
            ErrorAchievementsState(
              achievements: state.achievements,
              errorTitle: 'Error',
              errorText: 'Some error has occured',
            ),
          );
        },
      );
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

  // Is used to listen to the stream and be able to close subscription.
  Future<void> _listenStream<T>(
    Stream<T> stream, {
    required void Function(T data) onData,
    required void Function(Object error, StackTrace stackTrace) onError,
  }) {
    final completer = Completer<void>();

    _streamSubscription = stream.listen(
      onData,
      onDone: completer.complete,
      onError: onError,
      cancelOnError: false,
    );

    return completer.future.whenComplete(() {
      _streamSubscription.cancel();
    });
  }

  @override
  Future<void> close() async {
    await _streamSubscription.cancel();
    super.close();
  }
}
