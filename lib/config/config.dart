import 'package:flutter/material.dart';

class Config {
  static final Map<String, Map<String, Color>> _colors = {
    'actie': {
      'ringColor': Colors.lightGreen,
      'backgroundColor': Colors.green,
      'fillColor': Colors.greenAccent,
    },
    'rust': {
      'ringColor': Colors.grey,
      'backgroundColor': Colors.red,
      'fillColor': Colors.redAccent,
    },
    'pauze': {
      'ringColor': Colors.deepOrange,
      'backgroundColor': Colors.orange,
      'fillColor': Colors.orangeAccent,
    },
    'oefeningen': {
      'ringColor': Colors.lightBlue,
      'backgroundColor': Colors.blue,
      'fillColor': Colors.lightBlueAccent,
    },
    'herhalingen': {
      'ringColor': Colors.deepOrange,
      'backgroundColor': Colors.amber,
      'fillColor': Colors.amberAccent,
    },
  };

  static final Map<String, String> _descriptions = {
    'actie': 'Geef hieronder aan hoe lang we ons in het zweet gaan werken.',
    'rust': 'Geef hieronder aan hoeveel tijd we hebben tussen elke oefening.',
    'pauze':
        'Geef hieronder aan hoeveel er is tussen elk blokje van herhalingen.',
    'oefeningen':
        'Geef hieronder aan uit hoeveel oefeningen elk blokje bestaat.',
    'herhalingen':
        'Geef hieronder aan uit hoeveel blokjes deze training bestaat.',
  };

  static Color getRingColor(String screen) => _colors[screen]!['ringColor']!;
  static Color getBackgroundColor(String screen) =>
      _colors[screen]!['backgroundColor']!;
  static Color getFillColor(String screen) => _colors[screen]!['fillColor']!;
  static String getDescription(String screen) => _descriptions[screen]!;

  static String getVoice() => 'bart';
}
