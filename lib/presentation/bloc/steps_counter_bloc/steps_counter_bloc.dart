import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steps_counter/domain/repositories/steps_counter_repository.dart';
import 'package:steps_counter/presentation/bloc/steps_counter_bloc/steps_counter_event.dart';
import 'package:steps_counter/presentation/bloc/steps_counter_bloc/steps_counter_state.dart';

class StepsCounterBloc extends Bloc<StepsCounterEvent, StepsCounterState> {
  final StepsCounterRepository _stepsCounterRepository;

  late StreamSubscription _streamSubscription;

  StepsCounterBloc({
    required StepsCounterRepository stepsCounterRepository,
  })  : _stepsCounterRepository = stepsCounterRepository,
        super(const InitialStepsCounterState()) {
    on<InitializeStepsCounterEvent>(_init);
  }

  /// Initializes the user step counting stream.
  Future<void> _init(
    InitializeStepsCounterEvent event,
    Emitter<StepsCounterState> emit,
  ) async {
    try {
      final Stream<int> todayStepsStream =
          _stepsCounterRepository.todayStepsStream();

      await _listenStream(
        todayStepsStream,
        onData: (todaySteps) {
          emit(LoadedStepsCounterState(todaySteps: todaySteps));
        },
        onError: (error, stackTrace) {
          emit(
            const ErrorStepsCounterState(
              todaySteps: 0,
              errorTitle: 'Error',
              errorText: 'Some error has occured',
            ),
          );

          _streamSubscription.cancel();
        },
      );
    } catch (exception) {
      emit(
        const ErrorStepsCounterState(
          todaySteps: 0,
          errorTitle: 'Error',
          errorText: 'Some error has occured',
        ),
      );
      
      await _streamSubscription.cancel();
    }
  }

  // Is used to listen to the stream and be able to close subscription.
  Future<void> _listenStream<T>(
    Stream<T> stream, {
    required void Function(T data) onData,
    required void Function(Object error, StackTrace stackTrace) onError,
  }) {
    final completer = Completer<void>();

    _streamSubscription = stream.listen(
      onData,
      onDone: completer.complete,
      onError: onError,
      cancelOnError: false,
    );

    return completer.future.whenComplete(() {
      _streamSubscription.cancel();
    });
  }

  @override
  Future<void> close() async {
    await _streamSubscription.cancel();
    super.close();
  }
}
