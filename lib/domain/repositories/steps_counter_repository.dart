abstract class StepsCounterRepository {
  /// Returns a stream of the user's number of steps done for today.
  /// 
  /// Rethrows any arror that occures.
  Stream<int> todayStepsStream();
}
