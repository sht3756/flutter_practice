import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/stopwatch_bloc.dart';
import 'utils.dart';

class StopWatchScreen extends StatelessWidget {
  const StopWatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('스톱워치'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: BlocBuilder<StopwatchBloc, StopwatchState>(
              builder: (BuildContext context, StopwatchState state) {
                return Text(
                  formatElapsedTime(state.elapsedTime),
                  style: const TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<StopwatchBloc, StopwatchState>(
              builder: (BuildContext context, StopwatchState state) =>
                  ListView.builder(
                itemCount: state.laps.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text('Lap ${index + 1} : ${state.laps[index]}'),
                ),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            heroTag: 'start',
            onPressed: () =>
                context.read<StopwatchBloc>().add(const StopwatchStarted()),
            tooltip: '시작',
            child: const Icon(Icons.play_arrow),
          ),
          FloatingActionButton(
            heroTag: 'stop',
            onPressed: () =>
                context.read<StopwatchBloc>().add(const StopwatchStopped()),
            tooltip: '정지',
            child: const Icon(Icons.stop),
          ),
          FloatingActionButton(
            heroTag: 'reset',
            onPressed: () =>
                context.read<StopwatchBloc>().add(const StopWatchReset()),
            tooltip: '초기화',
            child: const Icon(Icons.refresh),
          ),
          FloatingActionButton(
            heroTag: 'record',
            onPressed: () =>
                context.read<StopwatchBloc>().add(const StopwatchRecorded()),
            tooltip: '랩 기록',
            child: const Icon(Icons.flag),
          ),
        ],
      ),
    );
  }
}
