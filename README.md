This app was developed and tested for Android devices.

Unfortunately my real device doesn't support activity recognition, so to test the app, I added Stream.periodic as a replacement for pedometer, so mainly app was tested in this case.
To use pedometer for a test, you just to go to the "i_steps_counter_repository.dart" file uncomment this code in method todayStepsStream:

      Stream<StepCount> stepCountStream =
          Pedometer.stepCountStream.asBroadcastStream();

      stepCountStream.listen((numberOfSteps) async {
        final User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          final int todayNumberOfSteps = await _countTodaySteps(
            numberOfSteps: numberOfSteps.steps,
          );

          // Saves number of steps done in one day to be used in achieves.
          _sharedPreferences.setInt(
            SharedPreferencesConstants.todayNumberOfStepskey,
            todayNumberOfSteps,
          );

          stepsStreamController.add(todayNumberOfSteps);
        } else {
          _stepCountStreamSubscription.cancel();
        }
      });

uncomment this:

    late StreamSubscription<int> _stepCountStreamSubscription;

and comment this code in method todayStepsStream:

    // Replacement for pedometer.
      Stream<int> stepsStreamPeriodic = Stream.periodic(
        const Duration(milliseconds: 300),
        (count) {
          int steps = count + 1;

          return steps;
        },
      ).take(100);

      // Counts steps.
      _stepsStreamPeriodicSubscription =
          stepsStreamPeriodic.listen((numberOfSteps) async {
        final User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          final int todayNumberOfSteps = await _countTodaySteps(
            numberOfSteps: numberOfSteps,
          );

          // Saves number of steps done in one day to be used in achieves.
          _sharedPreferences.setInt(
            SharedPreferencesConstants.todayNumberOfStepskey,
            todayNumberOfSteps,
          );

          stepsStreamController.add(todayNumberOfSteps);
        } else {
          _stepsStreamPeriodicSubscription.cancel();
        }
      });
