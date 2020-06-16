import 'package:IITDAPP/ThemeModel.dart';
import 'package:IITDAPP/globals.dart';
import 'package:IITDAPP/modules/settings/data/SettingsData.dart';
import 'package:IITDAPP/modules/settings/screens/IndivScreenSettings.dart';
import 'package:IITDAPP/modules/settings/widgets/SettingsTextWidgets.dart';
import 'file:///D:/Pranjal/Documents/DevClub/iitd%20app/IITDApp/lib/modules/settings/widgets/DarkModeSwitch.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsScreen extends StatefulWidget {
  static const String routeName = '/settings';
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    Container CustomDivider() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        height: 1,
        width: double.infinity,
        color: Colors.grey.shade400,
      );
    }

    // ignore: always_declare_return_types
    handleTap(tag) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => IndivScreenSettings(tag)));
    }

    var dropdownLis = {
      'System': ThemeType.System,
      'Dark': ThemeType.Dark,
      'Light': ThemeType.Light,
    };
    // ignore: non_constant_identifier_names
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(
          10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              color: Colors.purple,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(
                      'https://images.pexels.com/photos/1458332/pexels-photo-1458332.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
                ),
                title: Text(
                  currentUser.name ?? 'Guest',
                  style: TextStyle(fontSize: 17, color: Colors.white),
                ),
                trailing: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.fromLTRB(32, 8, 32, 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 8,
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Icon(
                      Icons.lock_outline,
                      color: Colors.purple,
                    ),
                    title: Text('Change Password'),
                    trailing: Icon(Icons.keyboard_arrow_right),
                  ),
                  CustomDivider(),
                  ListTile(
                    leading: Icon(
                      Icons.apps,
                      color: Colors.purple,
                    ),
                    title: Text('Change Course Details'),
                    trailing: Icon(Icons.keyboard_arrow_right),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            SettingsSectionHeading(text: 'Theme Settings'),
            SettingsDropdownTile(
              lis: dropdownLis,
              SPkey: commonKeys[1],
              text: 'Change Theme',
              defaultValue: defaultsForKey[commonKeys[1]],//Provider.of<ThemeModel>(context).themeType,
              onChange: (value) {
                Provider.of<ThemeModel>(context, listen: false)
                    .toggleTheme(value);
              },
              leading: IconButton(
                  onPressed: () {},
                  icon: DarkModeSwitch(
                    Theme.of(context).brightness == Brightness.dark,
                    onToggle: () {},
                  )),
            ),
            SizedBox(
              height: 25,
            ),
            SettingsSectionHeading(text: 'Notifications Settings'),
            SettingsSwitchTile(
              leading: AnimatedCrossFade(
                duration: Duration(seconds: 1),
                firstChild: Icon(Icons.notifications),
                secondChild: Icon(Icons.notifications_off),
                crossFadeState:
                    true ? CrossFadeState.showFirst : CrossFadeState.showSecond,
              ),
              SPkey: commonKeys[2],
              onChange: (bool value) {},
              defaultValue: true,
              text: 'Recieve Notifications',
            ),
            SizedBox(
              height: 30,
            ),
            SettingsSectionHeading(
              text: 'Individual Screens Settings',
            ),
            SizedBox(
              height: 10,
            ),
            SettingsTextButton(
              text: 'Dashboard',
              onTap: () {
                handleTap('Dashboard');
              },
            ),
            SettingsTextButton(text: 'Attendance'),
            SettingsTextButton(text: 'Events'),
            SettingsTextButton(
              text: 'Calendar',
              onTap: () {
                handleTap('Calendar');
              },
            ),
            SettingsTextButton(text: 'News'),
            SettingsTextButton(text: 'Map'),
            SizedBox(
              height: 30,
            ),
            SettingsSectionHeading(
              text: 'About',
            ),
            SizedBox(
              height: 5,
            ),
            SettingsTextButton(
              subtitle: 'version 1.1.2',
              text: 'About',
            )
          ],
        ),
      ),
    );
  }
}
