import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioProvider extends ChangeNotifier {
  final AudioPlayer _player = AudioPlayer();

  String _currentlyPlaying = '';
  String get currentlyPlayer => _currentlyPlaying;
  set currentlyPlaying(String v) => _currentlyPlaying = v;

  bool get playing =>
      _player.state != PlayerState.stopped &&
      _player.state != PlayerState.completed;

  void playDemo(String voice) async {
    _currentlyPlaying = voice;
    notifyListeners();

    _player.onPlayerComplete.listen((event) => notifyListeners());
    await _player.play(AssetSource('sounds/${voice.toLowerCase()}/demo.mp3'));

    notifyListeners();
  }

  void stop() {
    _player.stop();
    _currentlyPlaying = '';
    notifyListeners();
  }
}
