import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_study/course_1/bloc_1/utils.dart';

part 'stopwatch_event.dart';

part 'stopwatch_state.dart';

class StopwatchBloc extends Bloc<StopwatchEvent, StopwatchState> {
  final Stopwatch _stopwatch = Stopwatch();
  final Duration _tick = const Duration(milliseconds: 10);

  StopwatchBloc() : super(StopwatchState(elapsedTime: 0)) {
    on<StopwatchStarted>(_onStarted);
    on<StopwatchStopped>(_onStopped);
    on<StopWatchReset>(_onReset);
    on<StopwatchTicked>(_onTicked);
    on<StopwatchRecorded>(_onLapRecorded);
  }

  void _onStarted(StopwatchStarted event, Emitter<StopwatchState> emit) {
    _stopwatch.start();
    emit(state.copyWith(isRunning: true));
    _tickTimer();
  }

  void _onStopped(StopwatchStopped event, Emitter<StopwatchState> emit) {
    _stopwatch.stop();
    emit(state.copyWith(isRunning: false));
  }

  void _onReset(StopWatchReset event, Emitter<StopwatchState> emit) {
    _stopwatch.reset();
    emit(state.copyWith(elapsedTime: 0, laps: const []));
  }

  void _onTicked(StopwatchTicked event, Emitter<StopwatchState> emit) {
    emit(state.copyWith(elapsedTime: event.elapsedTime));
  }

  void _onLapRecorded(StopwatchRecorded event, Emitter<StopwatchState> emit) {
    final lapTime = formatElapsedTime(state.elapsedTime);
    final updatedLaps = List<String>.from(state.laps)..add(lapTime);
    emit(state.copyWith(laps: updatedLaps));
  }

  void _tickTimer() {
    Timer.periodic(_tick, (timer) {
      if (!_stopwatch.isRunning) {
        timer.cancel();
      } else {
        add(StopwatchTicked(elapsedTime: _stopwatch.elapsedMilliseconds));
      }
    });
  }
}
