import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:provider/provider.dart';
import 'package:timer_app/config/config.dart';
import 'package:timer_app/providers/color_provider.dart';
import 'package:timer_app/providers/timer_provider.dart';
import 'package:timer_app/screens/setup_screen.dart';

class CountDownTimer extends StatefulWidget {
  final int duration;
  final String type;
  final CountDownController controller;

  const CountDownTimer({
    super.key,
    required this.type,
    required this.duration,
    required this.controller,
  });

  @override
  State<CountDownTimer> createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer> {
  final _audioPlayer = AudioPlayer();
  late Color _ringColor;
  late Color _fillColor;
  late Color _backgroundColor;
  late String _voice;
  late AssetSource _endSound;

  @override
  void initState() {
    super.initState();
    debugPrint("Init state called: ${widget.type}");
    _voice = Config.getVoice();

    _audioPlayer.setReleaseMode(ReleaseMode.stop);
    _audioPlayer.pause();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final timer = Provider.of<TimerProvider>(context);
    final settings = Provider.of<InstellingenProvider>(context);
    _ringColor = Config.getRingColor(widget.type);
    _backgroundColor = Config.getBackgroundColor(widget.type);
    _fillColor = Config.getFillColor(widget.type);
    debugPrint(settings.toString());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: _backgroundColor,
        title: Text(
          widget.type,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),

      body: Column(
        children: [
          Text(timer.getCurrentText()),
          Center(
            child: CircularCountDownTimer(
              duration: widget.duration,
              controller: widget.controller,

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
                debugPrint('Countdown Ended');
                _audioPlayer.stop();
                timer.nextScreen();
              },

              onChange: (String timeStamp) async {
                if (int.parse(timeStamp) == 5) {
                  _endSound = widget.type == 'rust'
                      ? AssetSource('sounds/$_voice/actie.mp3')
                      : AssetSource('sounds/$_voice/stop.mp3');
                  debugPrint('playing audio...');
                  await _audioPlayer.play(_endSound);
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            onPressed: () {
              timer.isPaused ? timer.resume() : timer.pause();
            },
            child: timer.isPaused ? Text('Doorgaan') : Text('Pauzeren'),
          ),
          ElevatedButton(
            onPressed: () {
              timer.startTimers();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SetupScreen()),
              );
            },
            child: Text('Stoppen'),
          ),
        ],
      ),
    );
  }
}
