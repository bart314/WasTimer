import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:provider/provider.dart';
import 'package:timer_app/config/config.dart';
import 'package:timer_app/providers/audio_provider.dart';
import 'package:timer_app/providers/instellingen_provider.dart';
import 'package:timer_app/providers/timer_provider.dart';
import 'package:timer_app/screens/setup_screen.dart';

class CountDownTimer extends StatefulWidget {
  const CountDownTimer({super.key});

  @override
  State<CountDownTimer> createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer> {
  late Color _ringColor;
  late Color _fillColor;
  late Color _backgroundColor;
  bool _isPaused = false;

  final CountDownController _controller = CountDownController();

  @override
  Widget build(BuildContext context) {
    final timer = Provider.of<TimerProvider>(context);
    final player = Provider.of<AudioProvider>(context);
    player.voice = Provider.of<InstellingenProvider>(context).voice;
    final String curType = timer.type;

    _ringColor = Config.getRingColor(curType);
    _backgroundColor = Config.getBackgroundColor(curType);
    _fillColor = Config.getFillColor(curType);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: _backgroundColor,
        title: Text(
          curType,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),

      body: Column(
        children: [
          Text(timer.getCurrentText()),
          Center(
            child: CircularCountDownTimer(
              duration: timer.getTime(curType),
              controller: _controller,

              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height / 2,
              ringColor: _ringColor,
              fillColor: _fillColor,
              backgroundColor: _backgroundColor,
              strokeWidth: 20.0,
              strokeCap: StrokeCap.round,
              textStyle: const TextStyle(
                fontSize: 33.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textFormat: CountdownTextFormat.S,
              isReverse: true,
              isReverseAnimation: true,
              isTimerTextShown: true,

              onComplete: () {
                player.stop();
                timer.nextScreen();
                _controller.restart();
              },

              onChange: (String timeStamp) async {
                if (int.parse(timeStamp) == 5) {
                  curType == 'rust' ? player.playAction() : player.playRest();
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [pauseButton(), stopButton(context)],
      ),
    );
  }

  ElevatedButton stopButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // timer.startTimers();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SetupScreen()),
        );
      },
      child: Text('Stoppen'),
    );
  }

  ElevatedButton pauseButton() {
    return ElevatedButton(
      onPressed: () {
        if (_isPaused) {
          _controller.resume();
          setState(() => _isPaused = false);
        } else {
          _controller.pause();
          setState(() => _isPaused = true);
        }
      },
      child: _isPaused ? Text('Doorgaan') : Text('Pauzeren'),
    );
  }
}
