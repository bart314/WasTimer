import 'package:flutter/material.dart';

class TimerProvider extends ChangeNotifier {
  int _index = 0;
  int get index => _index;

  // reps is een combinatie van actie en rust
  // als we 8 oefeningen hebben, loopt rep van 0 tot en met 7
  int _currentRep = 0;

  // rondje is een combinatie van reps acties en rust
  // als we 6 rondjes hebben, loopt rondje van 0 tot en met 5
  int _currentRondje = 0;

  //states
  final int _actieState = 0;
  final int _pauzeState = 1;

  int _currentState = 0;

  final Map<String, int> _times = {
    'actie': 10,
    'rust': 10,
    'pauze': 10,
    'oefeningen': 3,
    'herhalingen': 2,
  };

  final List<String> _types = ["actie", "rust", "pauze"];
  String get type => _types[_index];

  String get total {
    var tmp = (_times['actie']! + _times['rust']!) * _times['oefeningen']!;
    tmp += _times['pauze']!;
    tmp *= _times['herhalingen']!;

    var t = Duration(seconds: tmp);
    return '${t.inMinutes}min, ${(t.inSeconds % 60).floor()}sec';
  }

  int getTime(String s) => _times[s]!;

  void nextScreen() {
    if (_currentState == _actieState) {
      // switchen van actie naar rust en vice versa
      if (_index == 0) {
        _index = 1;
      } else if (_index == 1) {
        _index = 0;
        _currentRep++;
      }
      debugPrint('Huidige oefening: $_currentRep');

      // zijn we door het rondje heen?
      if (_currentRep == _times['oefeningen']) {
        _index = 2; //pauze-scherm
        _currentState = _pauzeState;
      }
    } else if (_currentState == _pauzeState) {
      _index = 0; // herstarten van de oefeningen
      _currentRep = 0;
      _currentRondje++;
      _currentState = _actieState;
      debugPrint('Huidig rondje: $_currentRondje');

      if (_currentRondje == _times['herhalingen']) {
        debugPrint('einde');
      }
    }

    notifyListeners();
  }

  void setTime(String screen, int currentIntValue) {
    _times[screen] = currentIntValue;
    notifyListeners();
  }

  String getCurrentText() {
    int oefeningen = _times['oefeningen']!;
    int herhalingen = _times['herhalingen']!;

    String f1 = "${Icon(Icons.circle, color: Colors.green)}" * _currentRep;
    f1 +=
        Icon(Icons.circle, color: Colors.greenAccent).toString() *
        (oefeningen - _currentRep);

    return "Huidige oefening: ${_currentRep + 1} van $oefeningen\nHuidig rondje: ${_currentRondje + 1} van $herhalingen\n";
  }
}
