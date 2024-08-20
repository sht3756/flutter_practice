import 'package:flutter_bloc/flutter_bloc.dart';

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

  void _onStarted(StopwatchStarted event, Emitter<StopwatchState> emit) {}

  void _onStopped(StopwatchStopped event, Emitter<StopwatchState> emit) {}

  void _onReset(StopWatchReset event, Emitter<StopwatchState> emit) {}

  void _onTicked(StopwatchTicked event, Emitter<StopwatchState> emit) {}

  void _onLapRecorded(StopwatchRecorded event, Emitter<StopwatchState> emit) {}
}
