import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:steps_counter/common/navigation/app_router.dart';
import 'package:steps_counter/presentation/screens/main_screen/achivements_page/achivements_tab_bar.dart';

@RoutePage()
class AchivementsPage extends StatelessWidget {
  const AchivementsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AutoTabsRouter(
        routes: const [
          UserAchivementsRoute(),
          AllAchivementsRoute(),
        ],
        builder: (context, child) {
          return Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                const AchivementsTabBar(),
                const SizedBox(height: 30),
                Expanded(child: child),
              ],
            ),
          );
        },
      ),
    );
  }
}
