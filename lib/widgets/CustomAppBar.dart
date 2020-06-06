import 'package:IITDAPP/modules/login/userlogin/profile_icon.dart';
import 'package:IITDAPP/values/colors/Constants.dart';
import 'package:IITDAPP/values/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

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
    var actionsArray = <Widget>[ProfileIcon(logoutFunc)];
    if (actions != null) {
      actions.add(actionsArray[0]);
      actionsArray = actions;
    }
    return (GradientAppBar(
      title: title,
      elevation: 10,
      backgroundColorStart: AppColors.APP_BAR_START,
      backgroundColorEnd: AppColors.APP_BAR_END,
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
