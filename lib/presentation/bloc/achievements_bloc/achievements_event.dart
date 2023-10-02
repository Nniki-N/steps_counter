abstract class AchievementsEvent {
  const AchievementsEvent();
}

class InitializeAchievementsEvent extends AchievementsEvent {
  const InitializeAchievementsEvent();
}

class TrackForNewAchievementsEvent extends AchievementsEvent {
  const TrackForNewAchievementsEvent();
}
