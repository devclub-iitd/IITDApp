import 'package:IITDAPP/modules/settings/data/SettingsData.dart';
import 'package:IITDAPP/modules/settings/data/SettingsHandler.dart';

Future<String> generateDefaultScreenSubtitle() async {
  var res = await SettingsHandler.getSettingValue(commonKeys[0]);
  return 'Current Default is $res';
}

// ignore: always_declare_return_types
changeDefaultScreen(var value) async {
  await SettingsHandler.setSettingValue(commonKeys[0], value);
}
