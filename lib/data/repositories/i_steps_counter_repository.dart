import 'dart:async';
import 'package:pedometer/pedometer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:steps_counter/common/constants/shared_preferences_constants.dart';
import 'package:steps_counter/domain/repositories/steps_counter_repository.dart';

class IStepsCounterRepository implements StepsCounterRepository {
  IStepsCounterRepository();

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

      StreamController<int> stepsStreamController = StreamController<int>();
      Stream<int> stepsStream = stepsStreamController.stream;

      Stream<int> stepsStreamPeriodic = Stream.periodic(
        const Duration(milliseconds: 300),
        (count) {
          int steps = count + 1;

          return steps;
        },
      ).take(100);

      stepsStreamPeriodic.listen((numberOfSteps) async {
        final int todayNumberOfSteps = await _countTodaySteps(
          numberOfSteps: numberOfSteps,
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
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      final DateTime today = DateTime.now();

      int? savedNumberOfSteps;
      savedNumberOfSteps = prefs.getInt(
        SharedPreferencesConstants.lastNumberOfStepsKey,
      );

      String? lastSavedNumberOfStepsDateString = prefs.getString(
        SharedPreferencesConstants.lastNumberOfStepsDateKey,
      );
      lastSavedNumberOfStepsDateString ??= today.toString();
      DateTime lastSavedNumberOfStepsDate =
          DateTime.parse(lastSavedNumberOfStepsDateString);

      // log('---- 1');

      // First load
      if (savedNumberOfSteps == null) {
        savedNumberOfSteps = numberOfSteps;

        await prefs.setInt(
          SharedPreferencesConstants.lastNumberOfStepsKey,
          savedNumberOfSteps,
        );
        await prefs.setString(
          SharedPreferencesConstants.lastNumberOfStepsDateKey,
          today.toString(),
        );

        // log('---- 2');

        return numberOfSteps - savedNumberOfSteps;
      }

      // Pedometer was reseted
      if (numberOfSteps < savedNumberOfSteps) {
        savedNumberOfSteps = 0;

        await prefs.setInt(
          SharedPreferencesConstants.lastNumberOfStepsKey,
          savedNumberOfSteps,
        );
        await prefs.setString(
          SharedPreferencesConstants.lastNumberOfStepsDateKey,
          today.toString(),
        );

        // log('---- 3');
      }

      // The same day
      if (today.day == lastSavedNumberOfStepsDate.day &&
          today.month == lastSavedNumberOfStepsDate.month &&
          today.year == lastSavedNumberOfStepsDate.year) {
        await prefs.setString(
          SharedPreferencesConstants.lastNumberOfStepsDateKey,
          today.toString(),
        );

        // log('---- 4');

        return numberOfSteps - savedNumberOfSteps;
      }

      // Another day
      else {
        savedNumberOfSteps = numberOfSteps - 1;

        await prefs.setInt(
          SharedPreferencesConstants.lastNumberOfStepsKey,
          savedNumberOfSteps,
        );
        await prefs.setString(
          SharedPreferencesConstants.lastNumberOfStepsDateKey,
          today.toString(),
        );

        // log('---- 5');

        return numberOfSteps - savedNumberOfSteps;
      }
    } catch (exception) {
      rethrow;
    }
  }
}
