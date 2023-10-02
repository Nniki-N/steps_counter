
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steps_counter/common/navigation/app_router.dart';
import 'package:steps_counter/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:steps_counter/presentation/bloc/auth_bloc/auth_state.dart';
import 'package:steps_counter/presentation/screens/loading_screen/loading_screen.dart';

@RoutePage()
class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (content, authState) {
        // Navigates to the login screen if an error occurs.
        final authError = authState.error;
        if (authError != null) {
          context.router.replace(const SignInRoute());
        }

        // Navigates to the main screen if the user is logged in.
        if (authState is LoggedInAuthState) {
          context.router.replace(const MainRoute());
        }

        // Navigates to the signin screen if the user is logged out.
        if (authState is LoggedOutAuthState) {
          context.router.replace(const SignInRoute());
        }
      },
      child: const LoadingScreen(),
    );
  }
}
