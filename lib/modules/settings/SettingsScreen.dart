import 'package:IITDAPP/ThemeModel.dart';
import 'package:IITDAPP/modules/about/about.dart';
import 'package:IITDAPP/modules/settings/data/SettingsData.dart';
import 'package:IITDAPP/modules/settings/screens/IndivScreenSettings.dart';
import 'package:IITDAPP/modules/settings/utility/ResetSharedPrefs.dart';
import 'package:IITDAPP/modules/settings/widgets/DarkModeSwitch.dart';
import 'package:IITDAPP/modules/settings/widgets/SettingsTextWidgets.dart';
import 'package:IITDAPP/values/Constants.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void rebuildAllChildren(BuildContext context) {
  void rebuild(Element el) {
    el.markNeedsBuild();
    el.visitChildren(rebuild);
  }

  (context as Element).visitChildren(rebuild);
}

class SettingsScreen extends StatefulWidget {
  static const String routeName = '/settings';
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  var notif_value;

  @override
  void initState() {
    // TODO: implement initState
    notif_value = defaultsForKey[commonKeys[2]];
    super.initState();
  }

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

    // ignore: always_declare_return_types
    forceUpdateScreen() {
      Provider.of<ThemeModel>(context, listen: false)
          .toggleTheme(ThemeType.System);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => SettingsScreen()));
    }

    var dropdownLis = {
      'System': ThemeType.System,
      'Dark': ThemeType.Dark,
      'Light': ThemeType.Light,
    };
    // ignore: non_constant_identifier_names
    return Scaffold(
      backgroundColor: Provider.of<ThemeModel>(context, listen: true)
          .theme
          .SCAFFOLD_BACKGROUND,
      appBar: GradientAppBar(
          title: Text('Settings'),
          actions: <Widget>[PopupMenu(forceUpdateScreen)],
          backgroundColorStart:
              Provider.of<ThemeModel>(context).theme.APP_BAR_START,
          backgroundColorEnd:
              Provider.of<ThemeModel>(context).theme.APP_BAR_END),
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
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.purpleAccent
                  : Colors.purple,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(
                      'https://images.pexels.com/photos/1458332/pexels-photo-1458332.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
                ),
                title: Text(
                  currentUser != null ? currentUser.name : 'Guest',
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
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.purpleAccent
                          : Colors.purple,
                    ),
                    title: Text('Change Password'),
                    trailing: Icon(Icons.keyboard_arrow_right),
                  ),
                  CustomDivider(),
                  ListTile(
                    leading: Icon(
                      Icons.apps,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.purpleAccent
                          : Colors.purple,
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
              defaultValue: defaultsForKey[commonKeys[
                  1]], //Provider.of<ThemeModel>(context,listen:false).themeType,
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
                crossFadeState: notif_value
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
              ),
              SPkey: commonKeys[2],
              onChange: (bool value) {
                setState(() {
                  notif_value = value;
                });
              },
              defaultValue: defaultsForKey[commonKeys[2]],
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
            SettingsTextButton(
                text: 'Attendance',
                onTap: () {
                  handleTap('Attendance');
                }),
            SettingsTextButton(
              text: 'Events',
              onTap: () {
                handleTap('Events');
              },
            ),
            SettingsTextButton(
              text: 'Calendar',
              onTap: () {
                handleTap('Calendar');
              },
            ),
            SettingsTextButton(
              text: 'News',
              onTap: () {
                handleTap('News');
              },
            ),
            SettingsTextButton(
              text: 'Map',
              onTap: () {
                handleTap('Map');
              },
            ),
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
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AboutScreen()));
              },
            )
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class PopupMenu extends StatelessWidget {
  PopupMenu(this.callbackFunc);
  var callbackFunc;

  final menuArray = [
    PopupMenuItem<String>(
      value: 'Reset',
      child: Row(
        children: <Widget>[
          Icon(
            Icons.refresh,
            color: Color.fromRGBO(130, 130, 130, 0.8),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text('Reset to Default'),
          )
        ],
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // ignore: always_declare_return_types
    handleClick(val) async {
      var res = await SettingsAlertDialog(context,
          title: 'Are you sure you want to reset all settings',
          desc:
              'This will reset all currently stored app settings on this device',
          acceptButton: 'OK',
          cancelButton: 'Cancel');

      if (res == ConfirmAction.Accept) {
        // ignore: unused_local_variable
        var status = await resetSettingsSharedPrefs();
        callbackFunc();
      }
    }

    return PopupMenuButton<String>(
      onSelected: handleClick,
      itemBuilder: (BuildContext context) {
        return menuArray;
      },
    );
  }
}
