import 'package:IITDAPP/modules/settings/data/SettingsData.dart';
import 'package:IITDAPP/modules/settings/data/SettingsHandler.dart';
import 'package:IITDAPP/values/colors/colors.dart';
import 'package:IITDAPP/values/colors/darkColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

enum ThemeType { System, Light, Dark }

class ThemeModel extends ChangeNotifier {
  ThemeType themeType = ThemeType.System;
  ThemeModel() {
    initTheme();
  }

  AppColors dac = DarkAppColors();
  AppColors lac = AppColors();

  AppColors get theme {
    if (themeType == ThemeType.System) {
      var brightness = SchedulerBinding.instance.window.platformBrightness;
      var darkModeOn = brightness == Brightness.dark;
      if (darkModeOn) {
        return dac;
      } else {
        return lac;
      }
    } else if (themeType == ThemeType.Dark) {
      return dac;
    } else {
      return lac;
    }
  }

  void initTheme() async {
    var temp = await SettingsHandler.getSettingValue(commonKeys[1]);
    print('and the theme from sp is$temp');
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
    notifyListeners();
    return null;
  }

  // ignore: always_declare_return_types
  toggleTheme(ThemeType tType) {
    themeType = tType;
    return notifyListeners();
  }
}
