import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timer_app/config/config.dart';

// https://stackoverflow.com/a/72117605/10974490

class InstellingenProvider extends ChangeNotifier {
  static late final SharedPreferences _prefs;

  String _voice = 'Bart';
  String get voice {
    if (_prefs.containsKey('voice')) {
      _voice = _prefs.getString('voice')!;
    }
    return _voice;
  }

  set voice(String v) {
    _prefs.setString('voice', v);
    _voice = v;
    notifyListeners();
  }

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }
}
