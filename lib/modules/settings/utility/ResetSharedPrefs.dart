import 'package:IITDAPP/modules/settings/data/SettingsData.dart';
import 'package:IITDAPP/modules/settings/data/SettingsHandler.dart';

Future<bool> resetSettingsSharedPrefs() async{
  for (var e in defaultsForKey.entries){
    await SettingsHandler.setSettingValue(e.key, e.value);
  }
  return true;
}