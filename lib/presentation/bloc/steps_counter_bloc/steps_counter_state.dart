abstract class StepsCounterState {
  final int todaySteps;

  StepsCounterState({
    required this.todaySteps,
  });
}

class InitialStepsCounterState extends StepsCounterState {
  InitialStepsCounterState({
    int todaySteps = 0,
  }) : super(todaySteps: todaySteps);
}

class LoadedStepsCounterState extends StepsCounterState {
  LoadedStepsCounterState({
    required int todaySteps,
  }) : super(todaySteps: todaySteps);
}

class ErrorStepsCounterState extends StepsCounterState {
  final String errorTitle;
  final String errorText;

  ErrorStepsCounterState({
    required int todaySteps,
    required this.errorTitle,
    required this.errorText,
  }) : super(todaySteps: todaySteps);
}
