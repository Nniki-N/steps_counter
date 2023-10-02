import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steps_counter/common/di/locator.dart';
import 'package:steps_counter/common/navigation/app_router.dart';
import 'package:steps_counter/presentation/bloc/achievements_bloc/achievements_bloc.dart';
import 'package:steps_counter/presentation/bloc/achievements_bloc/achievements_event.dart';
import 'package:steps_counter/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:steps_counter/presentation/bloc/auth_bloc/auth_state.dart';
import 'package:steps_counter/presentation/bloc/steps_counter_bloc/steps_counter_bloc.dart';
import 'package:steps_counter/presentation/bloc/steps_counter_bloc/steps_counter_event.dart';
import 'package:steps_counter/presentation/screens/main_screen/custom_navigation_bottom_bar.dart';

@RoutePage()
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AchievementsBloc(
            achievementsRepository: getIt(),
            accountRepository: getIt(),
          )
            ..add(const InitializeAchievementsEvent())
            ..add(const TrackForNewAchievementsEvent()),
        ),
        BlocProvider(
          create: (context) => StepsCounterBloc(
            stepsCounterRepository: getIt(),
          )..add(InitializeStepsCounterEvent()),
        ),
      ],
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, authState) {
          // Navigates to the sign in screen if the user is logged iout.
          if (authState is LoggedOutAuthState) {
            AutoRouter.of(context).replace(const SignInRoute());
          }
        },
        child: AutoTabsRouter(
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
        ),
      ),
    );
  }
}
