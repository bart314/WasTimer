import 'package:audioplayers/audioplayers.dart';
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
    final timer = Provider.of<TimerProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WAS Timer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:
          SetupScreen(), //( screen: 'actie',), //SetupScreen(), //timer.currentScreen,
    );
  }
}

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  AudioPlayer _player = AudioPlayer();

  void initState() {
    super.initState();
    //_player.setSource(AssetSource('test.mp3'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('audio test')),
      body: Column(
        children: [
          Text(_player.state.toString()),
          ElevatedButton(
            onPressed: () async {
              await _player.play(AssetSource('sounds/test.mp3'));
            },
            child: Text('Test Audio'),
          ),
        ],
      ),
    );
  }
}
