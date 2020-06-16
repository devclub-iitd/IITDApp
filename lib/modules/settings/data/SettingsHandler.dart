import 'package:IITDAPP/modules/settings/data/SettingsData.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsHandler {
  static Future getSettingValue(String key) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    var res = await sharedPreferences.get(key);
    if(res==null) {
      await setSettingValue(key,defaultsForKey[key] );
      res = defaultsForKey[key];
    }
    return res;
  }

  static Future<String> setSettingValue(String key, var value) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    switch (value.runtimeType) {
      case int:
        await sharedPreferences.setInt(key, value);
        break;
      case String:
        await sharedPreferences.setString(key, value);
        break;
      case bool:
        await sharedPreferences.setBool(key, value);
        break;
      case double:
        await sharedPreferences.setDouble(key, value);
        break;
      case List:
        await sharedPreferences.setStringList(key, value);
        break;
      default:
        return 'Error occured';
    }
    return 'Successfull';
  }
}


