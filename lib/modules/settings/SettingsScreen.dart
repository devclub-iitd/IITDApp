import 'package:IITDAPP/ThemeModel.dart';
import 'package:IITDAPP/modules/about/about.dart';
import 'package:IITDAPP/modules/casiViews/password_change.dart';
import 'package:IITDAPP/modules/login/LoginStateProvider.dart';
import 'package:IITDAPP/modules/settings/data/SettingsData.dart';
import 'package:IITDAPP/modules/settings/data/SettingsHandler.dart';
import 'package:IITDAPP/modules/settings/screens/IndivScreenSettings.dart';
import 'package:IITDAPP/modules/settings/server/RequestManager.dart';
import 'package:IITDAPP/modules/settings/utility/ResetSharedPrefs.dart';
import 'package:IITDAPP/modules/settings/widgets/DarkModeSwitch.dart';
import 'package:IITDAPP/modules/settings/widgets/SettingsTextWidgets.dart';
import 'package:IITDAPP/routes/Routes.dart';
import 'package:IITDAPP/utility/analytics_manager.dart';
import 'package:IITDAPP/values/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math';

//import 'package:gradient_app_bar/gradient_app_bar.dart';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

void rebuildAllChildren(BuildContext context) {
  void rebuild(Element el) {
    el.markNeedsBuild();
    el.visitChildren(rebuild);
  }

  (context as Element).visitChildren(rebuild);
}

//

class SettingsScreen extends StatefulWidget {
  static const String routeName = '/settings';
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  var event_notif_value;
  bool news_notif_value;

  @override
  void initState() {
    // TODO: implement initState
    event_notif_value = defaultsForKey[commonKeys[2]];
    news_notif_value = defaultsForKey[commonKeys[4]];

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
    var cycles= 0;
    // ignore: non_constant_identifier_names
    return Scaffold(
      backgroundColor: Provider.of<ThemeModel>(context, listen: true)
          .theme
          .SCAFFOLD_BACKGROUND,
      appBar: AppBar(
        title: Text('Settings'),
        actions: <Widget>[ResetButton(resetMethod: forceUpdateScreen)],
        backgroundColor: Provider.of<ThemeModel>(context).theme.APP_BAR_START,
        // backgroundColorEnd:
        //     Provider.of<ThemeModel>(context).theme.APP_BAR_END),
      ),
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowGlow();
          return;
        },
        child: SingleChildScrollView(
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
                    backgroundImage: AssetImage(avImage),
                  ),
                  title: Text(
                    currentUser != null ? currentUser.name : 'Guest',
                    style: TextStyle(fontSize: 17, color: Colors.white),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      launchPasswordChangeScreen(token, context);
                    },
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
                    if (currentUser != null)
                      ListTile(
                        leading: Icon(
                          Icons.lock_outline,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.purpleAccent
                              : Colors.purple,
                        ),
                        title: Text('Change Password'),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        onTap: () {
                          launchPasswordChangeScreen(token, context);
                        },
                      ),
                    if (currentUser != null) CustomDivider(),
                    if (currentUser != null) CustomDivider(),
                    if (currentUser != null)
                      ListTile(
                        leading: Icon(
                          Icons.logout,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.purpleAccent
                              : Colors.purple,
                        ),
                        title: Text('Sign Out'),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        onTap: () {
                          context.read<LoginStateProvider>().signOut().then(
                              (value) => Navigator.pushReplacementNamed(
                                  context, Routes.loginPage));
                        },
                      ),
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              SettingsSectionHeading(text: 'Choose Dashboard Preferences'),
              SettingsDropdownTile(
                lis: avatars,
                SPkey: commonKeys[3],
                defaultValue: defaultsForKey[commonKeys[3]],
                leading: Icon(Icons.person),
                text: ' Choose an Avatar',
                onChange: (value) {
                  setState(() {});
                  //Provider.of<ThemeModel>(context, listen: false)
                  //.toggleTheme(value);
                  () {};
                  print('xyz');
                  print(xyz);
                  print(value);
                  if(value==xyz)
                  {
                    print('okokok');
                    setState(() {});
                    var rng= Random();
                    int cycles= rng.nextInt(4);
                    
                    print(cycles);
                    if(cycles==0)
                    {
                      value= 'assets/avatars/gojo.jpg';
                    }
                    if(cycles==1)
                    {
                      value= 'assets/avatars/mikasa.jpeg';
                    }
                    if(cycles==2)
                    {
                      value= 'assets/avatars/ninja.png';
                    }
                    if(cycles==3)
                    {
                      value= 'assets/avatars/panda.jpg';
                    }
                    
                  }
                  print(randomNumber);
                  avImage = value;
                  print(avImage);
                  () {};
                  //setState(() {});
                },
              ),
              SettingsDropdownTile(
                lis: backgroundimages,
                SPkey: commonKeys[5],
                defaultValue: defaultsForKey[commonKeys[5]],
                leading: Icon(CupertinoIcons.paintbrush_fill),
                text: ' Choose Cover Photo',
                onChange: (value) {
                  setState(() {});
                  //Provider.of<ThemeModel>(context, listen: false)
                  //.toggleTheme(value);
                  () {};
                  print(value);
                  bgimage = value;
                  print(bgimage);
                  () {};
                  setState(() {});
                },
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
                  logEvent(AnalyticsEvent.THEME_CHANGE,
                      value: value.toString());
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
                  crossFadeState: event_notif_value
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                ),
                SPkey: commonKeys[2],
                overrideOnChange: true,
                onChange: (bool value) async {
                  var res = await changeEventsNotificationState(value);
                  print(res is bool);
                  if (res) {
                    setState(() {
                      event_notif_value = value;
                    });
                    SettingsHandler.setSettingValue(commonKeys[2], value);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        duration: Duration(seconds: 2),
                        content:
                            Text('Unable To Change Notification Settings')));
                  }
                  return res;
                },
                defaultValue: defaultsForKey[commonKeys[2]],
                text: 'Event Notifications',
              ),
              SizedBox(
                height: 5,
              ),
              SettingsSwitchTile(
                leading: AnimatedCrossFade(
                  duration: Duration(seconds: 1),
                  firstChild: Icon(Icons.notifications),
                  secondChild: Icon(Icons.notifications_off),
                  crossFadeState: news_notif_value
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                ),
                SPkey: commonKeys[4],
                overrideOnChange: true,
                onChange: (bool value) async {
                  var res = await changeNewsNotificationState(value);
                  print(res is bool);
                  if (res) {
                    setState(() {
                      news_notif_value = value;
                    });
                    SettingsHandler.setSettingValue(commonKeys[4], value);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        duration: Duration(seconds: 2),
                        content:
                            Text('Unable To Change Notification Settings')));
                  }
                  return res;
                },
                defaultValue: defaultsForKey[commonKeys[4]],
                text: 'News Notifications',
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
              /*SettingsTextButton(
                text: 'Attendance',
                onTap: () {
                  handleTap('Attendance');
                }),*/
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
                subtitle: 'version $version',
                text: 'About',
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AboutScreen()));
                },
              ),
              // SettingsTextButton(
              //   text: 'Logout',
              //   onTap: () async {
              //     await Provider.of<LoginStateProvider>(context, listen: false)
              //         .signOut()
              //         .then((value) => Navigator.pushReplacementNamed(
              //             context, Routes.loginPage));
              //   },
              // )
            ],
          ),
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

class ResetButton extends StatelessWidget {
  final resetMethod;

  const ResetButton({Key key, this.resetMethod}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.refresh,
      ),
      onPressed: resetMethod,
    );
  }
}
