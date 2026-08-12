import 'package:flutter/material.dart';
import 'package:timer_app/services/preferences_service.dart';

// https://stackoverflow.com/a/72117605/10974490

class InstellingenProvider extends ChangeNotifier {
  String get voice => PreferencesService.getValue('voice');

  set voice(String v) {
    PreferencesService.setValue('voice', v);
    notifyListeners();
  }
}
