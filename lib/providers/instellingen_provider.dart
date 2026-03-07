import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timer_app/config/config.dart';

class InstellingenProvider extends ChangeNotifier {
  final Future<SharedPreferencesWithCache> _prefs =
      SharedPreferencesWithCache.create(
        cacheOptions: const SharedPreferencesWithCacheOptions(
          allowList: <String>{'screen1', 'screen2'},
        ),
      );

  late Map<String, Color> _currentColor;
  Map<String, Color> currentColor() => _currentColor;

  // Future<void> getColorScheme(String which) async {
  //   final prefs = SharedPreferencesAsync();
  //   final int externalCounter = (await prefs.getInt('externalCounter')) ?? 0;
  //   notifyListeners();
  // }

  Future<Set<ColorSwatch<int>>> getColorScheme(String which) async {
    final prefs = SharedPreferencesAsync();
    final int foo = await prefs.getInt('ctr') ?? 0;
    return {Colors.blue, Colors.amberAccent, Colors.amber};
  }

  Future<void> getColor(String what) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    //_currentColor['actie'] = Config.get
  }
}
