import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static late final SharedPreferences _prefs;
  static bool _initialized = false;

  static Future<void> init() async {
    if (_initialized) return;
    _prefs = await SharedPreferences.getInstance();
    _initialized = true;
  }

  static String getValue(String s) {
    return _prefs.getString(s) ?? '';
  }

  static void setValue(String s, String v) {
    _prefs.setString(s, v);
  }
}
