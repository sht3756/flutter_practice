part of 'stopwatch_bloc.dart';

sealed class StopwatchEvent {
  const StopwatchEvent();
}

final class StopwatchStarted extends StopwatchEvent {
  const StopwatchStarted();
}

final class StopwatchStopped extends StopwatchEvent {
  const StopwatchStopped();
}

final class StopWatchReset extends StopwatchEvent {
  const StopWatchReset();
}

final class StopwatchTicked extends StopwatchEvent {
  final int elapsedTime;

  StopwatchTicked({required this.elapsedTime});
}

final class StopwatchRecorded extends StopwatchEvent {
  const StopwatchRecorded();
}
