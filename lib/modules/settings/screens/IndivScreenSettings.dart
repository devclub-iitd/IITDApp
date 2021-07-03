import 'package:IITDAPP/modules/settings/data/SettingsData.dart';
import 'package:IITDAPP/modules/settings/data/SettingsHandler.dart';
import 'package:IITDAPP/modules/settings/widgets/SettingsTextWidgets.dart';
import 'package:IITDAPP/values/Constants.dart';

import 'package:IITDAPP/ThemeModel.dart';
//import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class IndivScreenSettings extends StatefulWidget {
  IndivScreenSettings(this.tag);
  final tag;
  @override
  _IndivScreenSettingsState createState() => _IndivScreenSettingsState();
}

class _IndivScreenSettingsState extends State<IndivScreenSettings> {
  var currentDefault;

  @override
  void initState() {
    getDefaultScreen();
    super.initState();
  }

  // ignore: always_declare_return_types
  getDefaultScreen() async {
    currentDefault = await SettingsHandler.getSettingValue(commonKeys[0]);
    setState(() {});
  }

  dynamic getItem(SettingsModel e) {
    if (e.heading) {
      return SettingsSectionHeading(
        text: e.defaultValue,
      );
    }
    return e.widgetType;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Provider.of<ThemeModel>(context).theme.SCAFFOLD_BACKGROUND,
      appBar: AppBar(
        title: Text('${widget.tag} Settings'),
        backgroundColor: Provider.of<ThemeModel>(context).theme.APP_BAR_START,
        // backgroundColorEnd:
        //     Provider.of<ThemeModel>(context).theme.APP_BAR_END),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SettingsTextButton(
              text: 'Set as default Screen',
              subtitle: 'Currently ${currentDefault} is set as default',
              showArrow: false,
              onTap: () async {
                await SettingsHandler.setSettingValue(
                    commonKeys[0], widget.tag);
                currentDefault = widget.tag;
                defaultScreen = widget.tag;
                setState(() {});
              },
            ),
            for (var e in indivScreenSettingsData[widget.tag]) getItem(e)

//            SettingsSliderRow(
//              title: 'Label Size',
//              trailing: Icon(Icons.location_on),
//            )
          ],
        ),
      ),
    );
  }
}
