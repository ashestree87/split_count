import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const SplitSecondCounterApp());
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
}

class SplitSecondCounterApp extends StatelessWidget {
  const SplitSecondCounterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplitSecondCounter(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplitSecondCounter extends StatefulWidget {
  const SplitSecondCounter({Key? key}) : super(key: key);

  @override
  _SplitSecondCounterState createState() => _SplitSecondCounterState();
}

class _SplitSecondCounterState extends State<SplitSecondCounter> {
  final ValueNotifier<Duration> _duration = ValueNotifier(const Duration());
  late Timer _timer;
  bool _timerPaused = false;

  @override
  void dispose() {
    if (_timer.isActive) {
      _timer.cancel();
    }
    super.dispose();
  }

  void _startTimer() {
    _timerPaused = false;
    _timer = Timer.periodic(const Duration(milliseconds: 10), (_) {
      if (!_timerPaused) {
        _duration.value += const Duration(milliseconds: 10);
      }
    });
  }

  void _stopTimer() {
    _timerPaused = true;
  }

  void _resetTimer() {
    if (_timer.isActive) {
      _timerPaused = true;
      _timer.cancel();
    }
    _duration.value = const Duration();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 2, 20),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ValueListenableBuilder<Duration>(
            valueListenable: _duration,
            builder: (context, duration, child) {
              final hours = duration.inHours;
              final minutes = duration.inMinutes.remainder(60);
              final seconds = duration.inSeconds.remainder(60);
              final milliseconds = duration.inMilliseconds.remainder(1000);
              return Column(
                children: <Widget>[
                  Text(
                    '$hours hr(s)',
                    style: const TextStyle(
                      fontSize: 80,
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '$minutes min(s)',
                    style: const TextStyle(
                      fontSize: 80,
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '$seconds sec',
                    style: const TextStyle(
                      fontSize: 80,
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '.${milliseconds.toString().padLeft(3, '0')}',
                    style: const TextStyle(
                      fontSize: 80,
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ElevatedButton(
                onPressed: _startTimer,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 43, 72, 214),
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(30),
                ),
                child: const Icon(Icons.play_arrow),
              ),
              ElevatedButton(
                onPressed: _stopTimer,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 43, 72, 214),
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(30),
                ),
                child: const Icon(Icons.pause),
              ),
              ElevatedButton(
                onPressed: _resetTimer,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 43, 72, 214),
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(30),
                ),
                child: const Icon(Icons.replay),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
