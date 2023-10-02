import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:steps_counter/common/navigation/app_router.dart';

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
                //
                context.router.replace(const SignInRoute());
              },
              child: const Text('Log out'),
            ),
          ],
        ),
      ),
    );
  }
}
