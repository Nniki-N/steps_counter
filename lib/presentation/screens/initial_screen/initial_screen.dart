import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:steps_counter/common/navigation/app_router.dart';

@RoutePage()
class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.router.replace(const SignInRoute());
          },
          child: const Text('Go to sign in'),
        ),
      ),
    );
  }
}
