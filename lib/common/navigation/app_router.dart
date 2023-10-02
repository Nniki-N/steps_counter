import 'package:auto_route/auto_route.dart';
import 'package:steps_counter/presentation/screens/auth_screens/registration_screen.dart';
import 'package:steps_counter/presentation/screens/auth_screens/signin_screen.dart';
import 'package:steps_counter/presentation/screens/initial_screen/initial_screen.dart';
import 'package:steps_counter/presentation/screens/loading_screen/loading_screen.dart';
import 'package:steps_counter/presentation/screens/main_screen/achivements_page/achivements_page.dart';
import 'package:steps_counter/presentation/screens/main_screen/achivements_page/tabs/all_achivements_tab.dart';
import 'package:steps_counter/presentation/screens/main_screen/achivements_page/tabs/user_achivements_tab.dart';
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
              children: [
                AutoRoute(
                  page: UserAchivementsRoute.page,
                  path: 'userAchivements',
                  initial: true,
                ),
                AutoRoute(
                  page: AllAchivementsRoute.page,
                  path: 'allAchivements',
                ),
              ],
            ),
          ],
        ),
      ];
}
