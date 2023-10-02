import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steps_counter/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:steps_counter/presentation/bloc/auth_bloc/auth_event.dart';
import 'package:steps_counter/presentation/bloc/steps_counter_bloc/steps_counter_bloc.dart';
import 'package:steps_counter/presentation/bloc/steps_counter_bloc/steps_counter_state.dart';

@RoutePage()
class StepsCounterPage extends StatelessWidget {
  const StepsCounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<StepsCounterBloc, StepsCounterState>(
      listener: (context, stepsCounterState) {
        if (stepsCounterState is ErrorStepsCounterState) {
          showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(stepsCounterState.errorTitle),
                content: Text(stepsCounterState.errorText),
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
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BlocBuilder<StepsCounterBloc, StepsCounterState>(
                builder: (context, stepsCounterState) {
                  return Text(
                    stepsCounterState.todaySteps.toString(),
                    style: const TextStyle(
                      fontSize: 35,
                    ),
                  );
                },
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
      ),
    );
  }
}
