import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:steps_counter/common/navigation/app_router.dart';
import 'package:steps_counter/data/datasources/firebase_auth_datasource.dart';
import 'package:steps_counter/data/repositories/firebase_auth_repository.dart';
import 'package:steps_counter/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:steps_counter/presentation/bloc/auth_bloc/auth_event.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter();

    return BlocProvider(
      create: (context) => AuthBloc(
        authRepository: FirebaseAuthRepository(
          authDatasource: FirebaseAuthDataSource(
            firebaseAuth: FirebaseAuth.instance,
            logger: Logger(),
          ),
        ),
      )..add(const InitializeAuthEvent()),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter.config(),
      ),
    );
  }
}
