import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steps_counter/common/di/locator.dart';
import 'package:steps_counter/common/navigation/app_router.dart';
import 'package:steps_counter/domain/entities/achivement.dart';
import 'package:steps_counter/presentation/bloc/achievements_bloc/achievements_bloc.dart';
import 'package:steps_counter/presentation/bloc/achievements_bloc/achievements_event.dart';
import 'package:steps_counter/presentation/bloc/achievements_bloc/achievements_state.dart';

@RoutePage()
class AchivementsPage extends StatelessWidget {
  const AchivementsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AchievementsBloc(
        achievementsRepository: getIt(),
      )..add(const InitializeAchievementsEvent()),
      child: Scaffold(
        body: BlocBuilder<AchievementsBloc, AchievementsState>(
          builder: (context, achievementsState) {
            final achievements = achievementsState.achievements;

            return ListView.separated(
              padding: const EdgeInsets.all(30),
              itemCount: achievements.length,
              itemBuilder: (context, index) {
                return AchievementListItem(achievement: achievements[index]);
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 20);
              },
            );
          },
        ),
      ),
    );
  }
}

class AchievementListItem extends StatelessWidget {
  final Achievement achievement;

  const AchievementListItem({
    super.key,
    required this.achievement,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: achievement.isAchieved ? 1 : 0.4,
      child: GestureDetector(
        onTap: () {
          context.router.push(AchievementRoute(
            achievement: achievement,
          ));
        },
        behavior: HitTestBehavior.opaque,
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              clipBehavior: Clip.hardEdge,
              child: CachedNetworkImage(
                imageUrl: achievement.imageLink,
                width: 220,
                height: 220,
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, progress) {
                  return CircularProgressIndicator(
                    value: progress.progress,
                  );
                },
                errorWidget: (context, url, error) {
                  return Container(
                    width: 250,
                    height: 250,
                    color: Colors.grey[400],
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Text(achievement.title),
          ],
        ),
      ),
    );
  }
}
