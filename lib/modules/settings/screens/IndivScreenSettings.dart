import 'package:IITDAPP/modules/settings/data/SettingsData.dart';
import 'package:IITDAPP/modules/settings/data/SettingsHandler.dart';
import 'package:IITDAPP/modules/settings/widgets/SettingsTextWidgets.dart';
import 'package:flutter/material.dart';

class IndivScreenSettings extends StatefulWidget {
  IndivScreenSettings(this.tag);
  var tag;
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

  dynamic getItem(SettingsModel e){
    if(e.heading){
      return SettingsSectionHeading(text: e.defaultValue,);
    }
    return e.widgetType;

  }

  @override
  Widget build(BuildContext context)  {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.tag} Settings'),
    ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SettingsTextButton(
              text: 'Set as default Screen',
              subtitle: 'Currently ${currentDefault} is set default'
            ),
            for (var e in indivScreenSettingsData[widget.tag])
              getItem(e)

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
