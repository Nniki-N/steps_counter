import 'dart:async';
import 'package:pedometer/pedometer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:steps_counter/common/constants/shared_preferences_constants.dart';
import 'package:steps_counter/domain/repositories/steps_counter_repository.dart';

class IStepsCounterRepository implements StepsCounterRepository {
  final SharedPreferences _sharedPreferences;

  IStepsCounterRepository({
    required SharedPreferences sharedPreferences,
  }) : _sharedPreferences = sharedPreferences;

  /// Returns a stream of the user's number of steps done for today.
  ///
  /// Rethrows any arror that occures.
  @override
  Stream<int> todayStepsStream() {
    try {
      // Stream<StepCount> stepCountStream =
      // Pedometer.stepCountStream.asBroadcastStream();

      // stepCountStream.listen((stepCount) async {
      //   // stepsStreamController.add(stepCount.steps);
      //   final int todaySteps = await countTodaySteps(
      //     stepsCount: stepCount.steps,
      //   );

      //   stepsStreamController.add(todaySteps);
      // });

      // Stream of the user's number of steps done for today.
      StreamController<int> stepsStreamController = StreamController<int>();
      Stream<int> stepsStream = stepsStreamController.stream;

      // Replacement for pedometer.
      Stream<int> stepsStreamPeriodic = Stream.periodic(
        const Duration(milliseconds: 300),
        (count) {
          int steps = count + 1;

          return steps;
        },
      ).take(100);

      // Counts steps.
      stepsStreamPeriodic.listen((numberOfSteps) async {
        final int todayNumberOfSteps = await _countTodaySteps(
          numberOfSteps: numberOfSteps,
        );

        // Saves number of steps done in one day to be used in achieves.
        _sharedPreferences.setInt(
          SharedPreferencesConstants.todayNumberOfStepskey,
          todayNumberOfSteps,
        );

        stepsStreamController.add(todayNumberOfSteps);
      });

      return stepsStream;
    } catch (exception) {
      rethrow;
    }
  }

  /// Calculates the user's number of steps done for today via saving info in the shared preferences.
  Future<int> _countTodaySteps({
    required int numberOfSteps,
  }) async {
    try {
      final DateTime today = DateTime.now();

      int? savedNumberOfSteps;
      savedNumberOfSteps = _sharedPreferences.getInt(
        SharedPreferencesConstants.lastNumberOfStepsKey,
      );

      // Is used to update number of steps for a new day.
      String? lastSavedNumberOfStepsDateString = _sharedPreferences.getString(
        SharedPreferencesConstants.lastNumberOfStepsDateKey,
      );
      lastSavedNumberOfStepsDateString ??= today.toString();
      DateTime lastSavedNumberOfStepsDate =
          DateTime.parse(lastSavedNumberOfStepsDateString);

      // Saves data in the first load.
      if (savedNumberOfSteps == null) {
        savedNumberOfSteps = numberOfSteps;

        await _sharedPreferences.setInt(
          SharedPreferencesConstants.lastNumberOfStepsKey,
          savedNumberOfSteps,
        );
        await _sharedPreferences.setString(
          SharedPreferencesConstants.lastNumberOfStepsDateKey,
          today.toString(),
        );

        return numberOfSteps - savedNumberOfSteps;
      }

      // Pedometer was reseted.
      if (numberOfSteps < savedNumberOfSteps) {
        savedNumberOfSteps = 0;

        await _sharedPreferences.setInt(
          SharedPreferencesConstants.lastNumberOfStepsKey,
          savedNumberOfSteps,
        );
        await _sharedPreferences.setString(
          SharedPreferencesConstants.lastNumberOfStepsDateKey,
          today.toString(),
        );
      }

      // Counts for the same day.
      if (today.day == lastSavedNumberOfStepsDate.day &&
          today.month == lastSavedNumberOfStepsDate.month &&
          today.year == lastSavedNumberOfStepsDate.year) {
        await _sharedPreferences.setString(
          SharedPreferencesConstants.lastNumberOfStepsDateKey,
          today.toString(),
        );

        return numberOfSteps - savedNumberOfSteps;
      }

      // Resets number of steps for nother day.
      else {
        savedNumberOfSteps = numberOfSteps - 1;

        await _sharedPreferences.setInt(
          SharedPreferencesConstants.lastNumberOfStepsKey,
          savedNumberOfSteps,
        );
        await _sharedPreferences.setString(
          SharedPreferencesConstants.lastNumberOfStepsDateKey,
          today.toString(),
        );

        return numberOfSteps - savedNumberOfSteps;
      }
    } catch (exception) {
      rethrow;
    }
  }
}
