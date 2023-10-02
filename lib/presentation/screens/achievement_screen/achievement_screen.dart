import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:steps_counter/domain/entities/achivement.dart';

@RoutePage()
class AchievementScreen extends StatelessWidget {
  final Achievement achievement;

  const AchievementScreen({
    super.key,
    required this.achievement,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(achievement.title),
              const SizedBox(height: 10),
              Text(
                achievement.description,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  context.router.pop();
                },
                child: const Text('Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
