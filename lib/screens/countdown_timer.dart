import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:provider/provider.dart';
import 'package:timer_app/config/config.dart';
import 'package:timer_app/providers/instellingen_provider.dart';
import 'package:timer_app/providers/timer_provider.dart';
import 'package:timer_app/screens/setup_screen.dart';

class CountDownTimer extends StatefulWidget {
  const CountDownTimer({super.key});

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
  bool _isPaused = false;

  final CountDownController _controller = CountDownController();

  @override
  void initState() {
    super.initState();
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
    final String curType = timer.type;

    // final settings = Provider.of<InstellingenProvider>(context);
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
                debugPrint('Countdown Ended');
                _audioPlayer.stop();
                timer.nextScreen();
                _controller.restart();
              },

              onChange: (String timeStamp) async {
                if (int.parse(timeStamp) == 5) {
                  _endSound = curType == 'rust'
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
