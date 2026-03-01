import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InstellingenProvider extends ChangeNotifier {
  final Future<SharedPreferencesWithCache> _prefs =
      SharedPreferencesWithCache.create(
        cacheOptions: const SharedPreferencesWithCacheOptions(
          allowList: <String>{'screen1', 'screen2'},
        ),
      );

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
}
