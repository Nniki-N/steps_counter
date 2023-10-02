import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steps_counter/common/di/locator.dart';
import 'package:steps_counter/common/navigation/app_router.dart';
import 'package:steps_counter/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:steps_counter/presentation/bloc/auth_bloc/auth_event.dart';
import 'package:steps_counter/presentation/bloc/steps_counter_bloc/steps_counter_bloc.dart';
import 'package:steps_counter/presentation/bloc/steps_counter_bloc/steps_counter_event.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(
            authRepository: getIt(),
          )..add(const InitializeAuthEvent()),
        ),
        BlocProvider(
          create: (context) => StepsCounterBloc(
            stepsCounterRepository: getIt(),
          )..add(InitializeStepsCounterEvent()),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter.config(),
      ),
    );
  }
}
