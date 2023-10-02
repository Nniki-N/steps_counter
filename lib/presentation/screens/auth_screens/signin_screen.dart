import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:steps_counter/common/navigation/app_router.dart';

@RoutePage()
class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Sign in'),
                  TextButton(
                    onPressed: () {
                      //
                      context.router.replace(const RegistrationRoute());
                    },
                    child: const Text('Register'),
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
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  //
                  context.router.replace(const MainRoute());
                },
                child: const Text('Sign In'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
