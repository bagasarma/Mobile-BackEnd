import 'dart:async';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class StreamPage extends StatelessWidget {
  StreamPage({super.key});

  final StreamController<double> streamController = StreamController<double>.broadcast();

  Stream<double> count() async* {
    double percent = 100.0;
    while (percent >= 0) {
      await Future.delayed(const Duration(seconds: 1));
      yield percent;
      percent -= 5;
    }
  }

  void startStream(StreamController<double> controller) {
    count().listen((percent) {
      controller.add(percent);
    });
  }

  @override
  Widget build(BuildContext context) {
    StreamSubscription<double>? subs;

    return Scaffold(
      appBar: AppBar(title: const Text('Stream Screen')),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            StreamBuilder<double>(
              stream: streamController.stream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return const Text('Error');
                }
                final percent = snapshot.data ?? 100.0;
                return CircularPercentIndicator(
                  radius: 60.0,
                  lineWidth: 10.0,
                  percent: percent / 100.0,
                  center: Text(
                    percent == 100.0 ? "Full" : "${percent.toInt()}%",
                    style: const TextStyle(fontSize: 20),
                  ),
                  progressColor: Colors.blue,
                );
              },
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    streamController.add(100.0);
                    subs?.cancel();
                    subs = null;
                  },
                  child: const Text('Reset'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (subs == null) {
                      subs = count().listen((percent) {
                        streamController.add(percent);
                      });
                    } else if (subs!.isPaused) {
                      subs!.resume();
                    }
                  },
                  child: const Text('Play'),
                ),
                ElevatedButton(
                  onPressed: () {
                    subs?.pause();
                  },
                  child: const Text('Stop'),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (subs == null) {
            subs = count().listen((percent) {
              streamController.add(percent);
            });
          } else if (subs!.isPaused) {
            subs!.resume();
          }
        },
        tooltip: 'Play',
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}