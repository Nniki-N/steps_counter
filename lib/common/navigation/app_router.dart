import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:steps_counter/domain/entities/achivement.dart';
import 'package:steps_counter/presentation/screens/achievement_screen/achievement_screen.dart';
import 'package:steps_counter/presentation/screens/auth_screens/registration_screen.dart';
import 'package:steps_counter/presentation/screens/auth_screens/signin_screen.dart';
import 'package:steps_counter/presentation/screens/initial_screen/initial_screen.dart';
import 'package:steps_counter/presentation/screens/loading_screen/loading_screen.dart';
import 'package:steps_counter/presentation/screens/main_screen/achievements_page/achievements_page.dart';
import 'package:steps_counter/presentation/screens/main_screen/main_screen.dart';
import 'package:steps_counter/presentation/screens/main_screen/steps_counter_page/steps_counter_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(
  replaceInRouteName: 'Page|Screen|Tab,Route',
)
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: InitialRoute.page,
          path: '/',
          initial: true,
        ),
        AutoRoute(
          page: LoadingRoute.page,
          path: '/loading',
        ),
        AutoRoute(
          page: SignInRoute.page,
          path: '/signin',
        ),
        AutoRoute(
          page: RegistrationRoute.page,
          path: '/registration',
        ),
        AutoRoute(
          page: MainRoute.page,
          path: '/main',
          children: [
            AutoRoute(
              page: StepsCounterRoute.page,
              path: 'stepsCounter',
              initial: true,
            ),
            AutoRoute(
              page: AchivementsRoute.page,
              path: 'achevements',
            ),
          ],
        ),
        AutoRoute(
          page: AchievementRoute.page,
          path: '/achievement',
        ),
      ];
}
