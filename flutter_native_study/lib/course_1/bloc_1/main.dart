import 'dart:async';

import 'package:flutter/material.dart';

import 'utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: StopWatchScreen());
  }
}

class StopWatchScreen extends StatefulWidget {
  const StopWatchScreen({super.key});

  @override
  State<StopWatchScreen> createState() => _StopWatchScreenState();
}

class _StopWatchScreenState extends State<StopWatchScreen> {
  final Stopwatch _stopwatch = Stopwatch();
  final Duration _tick = const Duration(milliseconds: 10); // 10 밀리초 간겱

  late Timer _timer;
  late StreamController<int> _streamController;

  final _laps = [];

  void _startTimer() {
    if (!_stopwatch.isRunning) {
      _stopwatch.start();
      _timer = Timer.periodic(_tick, (Timer t) {
        _streamController.add(_stopwatch.elapsedMilliseconds);
      });
    }
  }

  void _stopTimer() {
    if (_stopwatch.isRunning) {
      _stopwatch.stop();
      _timer.cancel();
    }
  }

  void _resetTimer() {
    _stopwatch.reset();
    _streamController.add(0);
    setState(() {
      _laps.clear();
    });
  }

  void _recordLap() {
    final milliseconds = _stopwatch.elapsedMilliseconds;
    final lapTime = formatElapsedTime(milliseconds);
    setState(() {
      _laps.add(lapTime);
    });
  }

  @override
  void initState() {
    super.initState();
    _streamController = StreamController<int>();
  }

  @override
  void dispose() {
    _timer.cancel();
    _streamController.close();
    super.dispose();
  }

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
            child: StreamBuilder<int>(
              stream: _streamController.stream,
              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                final milliseconds = snapshot.data ?? 0;
                return Text(
                  formatElapsedTime(milliseconds),
                  style: const TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _laps.length,
              itemBuilder: (context, index) => ListTile(
                title: Text('Lap ${index + 1} : ${_laps[index]}'),
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
            onPressed: _startTimer,
            tooltip: '시작',
            child: const Icon(Icons.play_arrow),
          ),
          FloatingActionButton(
            heroTag: 'stop',
            onPressed: _stopTimer,
            tooltip: '정지',
            child: const Icon(Icons.stop),
          ),
          FloatingActionButton(
            heroTag: 'reset',
            onPressed: _resetTimer,
            tooltip: '초기화',
            child: const Icon(Icons.refresh),
          ),
          FloatingActionButton(
            heroTag: 'record',
            onPressed: _recordLap,
            tooltip: '랩 기록',
            child: const Icon(Icons.flag),
          ),
        ],
      ),
    );
  }
}
