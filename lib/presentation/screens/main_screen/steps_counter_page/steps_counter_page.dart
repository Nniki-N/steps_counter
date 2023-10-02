import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steps_counter/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:steps_counter/presentation/bloc/auth_bloc/auth_event.dart';

@RoutePage()
class StepsCounterPage extends StatelessWidget {
  const StepsCounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '0',
              style: TextStyle(
                fontSize: 35,
              ),
            ),
            const SizedBox(height: 10),
            const Text('Steps today'),
            const SizedBox(height: 100),
            ElevatedButton(
              onPressed: () {
                context.read<AuthBloc>().add(const LogOutAuthEvent());
              },
              child: const Text('Log out'),
            ),
          ],
        ),
      ),
    );
  }
}
