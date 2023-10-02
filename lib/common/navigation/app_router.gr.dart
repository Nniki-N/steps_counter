// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AchievementRoute.name: (routeData) {
      final args = routeData.argsAs<AchievementRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AchievementScreen(
          key: args.key,
          achievement: args.achievement,
        ),
      );
    },
    AchivementsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AchivementsPage(),
      );
    },
    InitialRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const InitialScreen(),
      );
    },
    LoadingRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LoadingScreen(),
      );
    },
    MainRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MainScreen(),
      );
    },
    RegistrationRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const RegistrationScreen(),
      );
    },
    SignInRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SignInScreen(),
      );
    },
    StepsCounterRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const StepsCounterPage(),
      );
    },
  };
}

/// generated route for
/// [AchievementScreen]
class AchievementRoute extends PageRouteInfo<AchievementRouteArgs> {
  AchievementRoute({
    Key? key,
    required Achievement achievement,
    List<PageRouteInfo>? children,
  }) : super(
          AchievementRoute.name,
          args: AchievementRouteArgs(
            key: key,
            achievement: achievement,
          ),
          initialChildren: children,
        );

  static const String name = 'AchievementRoute';

  static const PageInfo<AchievementRouteArgs> page =
      PageInfo<AchievementRouteArgs>(name);
}

class AchievementRouteArgs {
  const AchievementRouteArgs({
    this.key,
    required this.achievement,
  });

  final Key? key;

  final Achievement achievement;

  @override
  String toString() {
    return 'AchievementRouteArgs{key: $key, achievement: $achievement}';
  }
}

/// generated route for
/// [AchivementsPage]
class AchivementsRoute extends PageRouteInfo<void> {
  const AchivementsRoute({List<PageRouteInfo>? children})
      : super(
          AchivementsRoute.name,
          initialChildren: children,
        );

  static const String name = 'AchivementsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [InitialScreen]
class InitialRoute extends PageRouteInfo<void> {
  const InitialRoute({List<PageRouteInfo>? children})
      : super(
          InitialRoute.name,
          initialChildren: children,
        );

  static const String name = 'InitialRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LoadingScreen]
class LoadingRoute extends PageRouteInfo<void> {
  const LoadingRoute({List<PageRouteInfo>? children})
      : super(
          LoadingRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoadingRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MainScreen]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute({List<PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [RegistrationScreen]
class RegistrationRoute extends PageRouteInfo<void> {
  const RegistrationRoute({List<PageRouteInfo>? children})
      : super(
          RegistrationRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegistrationRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SignInScreen]
class SignInRoute extends PageRouteInfo<void> {
  const SignInRoute({List<PageRouteInfo>? children})
      : super(
          SignInRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignInRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [StepsCounterPage]
class StepsCounterRoute extends PageRouteInfo<void> {
  const StepsCounterRoute({List<PageRouteInfo>? children})
      : super(
          StepsCounterRoute.name,
          initialChildren: children,
        );

  static const String name = 'StepsCounterRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
