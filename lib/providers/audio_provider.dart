import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioProvider extends ChangeNotifier {
  final AudioPlayer _player = AudioPlayer();

  AudioProvider() {
    _player.setReleaseMode(ReleaseMode.stop);
    _player.pause();
  }

  String _voice = 'bart';
  set voice(String v) => _voice = v;

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

  void playAction() {
    _player.play(AssetSource('sounds/${_voice.toLowerCase()}/actie.mp3'));
    _currentlyPlaying = 'actie';
  }

  void playRest() {
    _player.play(AssetSource('sounds/${_voice.toLowerCase()}/stop.mp3'));
    _currentlyPlaying = 'stop';
  }
}
