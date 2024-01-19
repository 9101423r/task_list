import 'package:flutter/material.dart';

import 'package:task_list/l10n/all_locales.dart';

class LocaleProvider with ChangeNotifier {
  Locale _locale;
  Locale get locale => _locale;

  LocaleProvider() : _locale = AllLocale.all[0];

  void setLocale(Locale locale) {
    if (!AllLocale.all.contains(locale)) return;
    _locale = locale;
    notifyListeners();
  }

  void changeLocale() {
    if (locale == AllLocale.all[0]) {
      setLocale(AllLocale.all[1]);
    } else {
      setLocale(AllLocale.all[0]);
    }
  }

  Map<String, dynamic> _configMap = {};
  Map<String, dynamic> get configMap => _configMap;

  void setJsonForMap(Map<String, dynamic> json) {
    _configMap = json;
  }
}
