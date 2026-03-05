import 'package:audioplayers/audioplayers.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timer_app/providers/color_provider.dart';
import 'package:timer_app/providers/timer_provider.dart';
import 'package:timer_app/screens/setup_screen.dart';

void main() => runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => TimerProvider()),
      ChangeNotifierProvider(create: (context) => InstellingenProvider()),
    ],
    child: const WasTimer(),
  ),
);

class WasTimer extends StatefulWidget {
  const WasTimer({super.key});

  @override
  State<WasTimer> createState() => _WasTimerState();
}

class _WasTimerState extends State<WasTimer> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WAS Timer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SetupScreen(), //TestScreen(),
      //SetupScreen(), //( screen: 'actie',), //SetupScreen(), //timer.currentScreen,
    );
  }
}

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    final timeProvider = Provider.of<TimerProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Refactor Test')),
      body: Center(
        child: Column(
          children: [
            // Text(timeProvider.timers[timeProvider.index].type),
            CircularCountDownTimer(
              width: 100,
              height: 100,
              duration: 10,
              fillColor: Colors.green,
              ringColor: Colors.greenAccent,
              autoStart: true,
              onComplete: () => timeProvider.nextScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
