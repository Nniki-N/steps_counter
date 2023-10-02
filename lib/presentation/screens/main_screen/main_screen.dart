import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:steps_counter/common/navigation/app_router.dart';
import 'package:steps_counter/presentation/screens/main_screen/custom_navigation_bottom_bar.dart';

@RoutePage()
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
        routes: const [
          StepsCounterRoute(),
          AchivementsRoute(),
        ],
        transitionBuilder: (context, child, animation) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        curve: Curves.easeInOutCirc,
        duration: const Duration(milliseconds: 500),
        lazyLoad: false,
        builder: (context, child) {
          return Scaffold(
            body: child,
            bottomNavigationBar: const CustomBottomNavigationBar(),
          );
        },
      );
  }
}
