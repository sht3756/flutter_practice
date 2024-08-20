part of 'stopwatch_bloc.dart';

class StopwatchState {
  final int elapsedTime;
  final bool isRunning;
  final List<String> laps;

  StopwatchState({
    required this.elapsedTime,
    this.isRunning = false,
    this.laps = const [],
  });

  StopwatchState copyWith({
    int? elapsedTime,
    bool? isRunning,
    List<String>? laps,
  }) =>
      StopwatchState(
        elapsedTime: elapsedTime ?? this.elapsedTime,
        isRunning: isRunning ?? this.isRunning,
        laps: laps ?? this.laps,
      );
}
