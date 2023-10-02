import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:steps_counter/common/navigation/app_router.dart';
import 'package:steps_counter/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:steps_counter/presentation/bloc/auth_bloc/auth_state.dart';
import 'package:steps_counter/presentation/screens/loading_screen/loading_screen.dart';

@RoutePage()
class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: Permission.activityRecognition.isGranted,
      builder: (context, snapshot) {
        // Permission is granted.
        if (snapshot.hasData && snapshot.data!) {
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

        // Permission is denied.
        else if (snapshot.hasData && !snapshot.data!) {
          return Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'To use this app you need to grant permission for accessing the activity recognition',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () async {
                        final PermissionStatus permissionStatus =
                            await Permission.activityRecognition.request();

                        if (permissionStatus.isGranted) {
                          setState(() {});
                        }
                      },
                      child: const Text('Change Permission'),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        //  Waiting for data.
        else {
          return const LoadingScreen();
        }
      },
    );
  }
}
