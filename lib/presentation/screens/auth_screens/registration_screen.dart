import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steps_counter/common/errors/auth_error.dart';
import 'package:steps_counter/common/navigation/app_router.dart';
import 'package:steps_counter/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:steps_counter/presentation/bloc/auth_bloc/auth_event.dart';
import 'package:steps_counter/presentation/bloc/auth_bloc/auth_state.dart';
import 'package:steps_counter/presentation/screens/loading_screen/loading_screen.dart';

@RoutePage()
class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, authState) {
        // Checks if an error occurs and if error message has to be shown.
        final AuthError? authError = authState.error;
        if (authError != null) {
          showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(authError.errorTitle),
                content: Text(authError.errorText),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Ok'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }

        // Navigates to the main screen if the user is logged in.
        else if (authState is LoggedInAuthState) {
          AutoRouter.of(context).replace(const MainRoute());
        }
      },
      builder: (context, authState) {
        // Loading screen.
        if (authState is LoadingAuthState || authState is LoggedInAuthState) {
          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: const LoadingScreen(),
          );
        }

        // Registration screen layout.
        else {
          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Scaffold(
              body: Center(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Register'),
                          TextButton(
                            onPressed: () {
                              context.router.replace(const SignInRoute());
                            },
                            child: const Text('Sign In'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(hintText: 'Email'),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: passwordController,
                        decoration: const InputDecoration(hintText: 'Password'),
                        obscureText: true,
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          final email = emailController.text.trim();
                          final password = passwordController.text.trim();

                          if (email.isNotEmpty && password.isNotEmpty) {
                            context.read<AuthBloc>().add(RegisterAuthEvent(
                                  email: email,
                                  password: password,
                                ));
                          }
                        },
                        child: const Text('Register'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
