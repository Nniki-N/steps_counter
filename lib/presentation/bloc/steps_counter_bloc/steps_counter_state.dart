abstract class StepsCounterState {
  final int todaySteps;

  const StepsCounterState({
    required this.todaySteps,
  });
}

class InitialStepsCounterState extends StepsCounterState {
  const InitialStepsCounterState({
    int todaySteps = 0,
  }) : super(todaySteps: todaySteps);
}

class LoadedStepsCounterState extends StepsCounterState {
  const LoadedStepsCounterState({
    required int todaySteps,
  }) : super(todaySteps: todaySteps);
}

class ErrorStepsCounterState extends StepsCounterState {
  final String errorTitle;
  final String errorText;

  const ErrorStepsCounterState({
    required int todaySteps,
    required this.errorTitle,
    required this.errorText,
  }) : super(todaySteps: todaySteps);
}
