import 'package:IITDAPP/modules/login/userlogin/profile_dialog.dart';
import 'package:IITDAPP/modules/settings/SettingsScreen.dart';
import 'package:IITDAPP/values/Constants.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:provider/provider.dart';

import '../ThemeModel.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  CustomAppBar(
      {Key key,
      this.title,
      this.bottom,
      this.height,
      this.actions,
      this.withMenu = true})
      : super(key: key);
  final Widget bottom;
  final Widget title;
  final bool withMenu;
  final double height;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    var actionsArray = <Widget>[PopupMenu()];
    if (actions != null) {
      actions.add(actionsArray[0]);
      actionsArray = actions;
    }
    return (GradientAppBar(
      title: title,
      elevation: 10,
      backgroundColorStart:
          Provider.of<ThemeModel>(context).theme.APP_BAR_START,
      backgroundColorEnd: Provider.of<ThemeModel>(context).theme.APP_BAR_END,
      actions: actionsArray,
      leading: withMenu
          ? Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
                );
              },
            )
          : null,
      bottom: bottom,
    ));
  }

  @override
  Size get preferredSize => Size.fromHeight((height ?? 1) * kToolbarHeight);
}

// ignore: must_be_immutable
class PopupMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: always_declare_return_types

    var menuArray = [
      PopupMenuItem<String>(
        value: 'Settings',
        child: Row(
          children: <Widget>[
            Icon(
              Icons.settings,
              color: Provider.of<ThemeModel>(context).theme.PRIMARY_TEXT_COLOR,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text('Settings'),
            )
          ],
        ),
      ),
      PopupMenuItem<String>(
        value: 'User Profile',
        child: Row(
          children: <Widget>[
            Icon(
              Icons.person,
              color: Provider.of<ThemeModel>(context).theme.PRIMARY_TEXT_COLOR,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text('User Profile'),
            ),
          ],
        ),
      ),
    ];

    void handleClick(value) {
      switch (value) {
        case 'User Profile':
          showAlert(context, loginFunc);
          break;
        case 'Settings':
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => SettingsScreen()));
          break;
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
