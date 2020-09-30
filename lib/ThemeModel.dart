import 'package:IITDAPP/modules/settings/data/SettingsData.dart';
import 'package:IITDAPP/modules/settings/data/SettingsHandler.dart';
import 'package:flutter/material.dart';

enum ThemeType { System, Light, Dark }

class ThemeModel extends ChangeNotifier {
  ThemeType themeType = ThemeType.System;
  ThemeModel() {
    initTheme();
  }

  void initTheme() async {
    var temp = await SettingsHandler.getSettingValue(commonKeys[1]);
    print('and the theme from sp is${temp}');
    switch (temp) {
      case 'System':
        themeType = ThemeType.System;
        break;
      case 'Dark':
        themeType = ThemeType.Dark;
        break;
      case 'Light':
        themeType = ThemeType.Light;
    }
    return null;
  }

  // ignore: always_declare_return_types
  toggleTheme(ThemeType tType) {
    themeType = tType;
    return notifyListeners();
  }
}
