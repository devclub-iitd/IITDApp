import 'package:IITDAPP/values/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';



class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  CustomAppBar({Key key, this.title, this.bottom, this.height})
      : super(key: key);
  final Widget bottom;
  final Widget title;
  final double height;

  @override
  Widget build(BuildContext context) {
    return (GradientAppBar(
      title: title,
      elevation: 10,
      backgroundColorStart: AppColors.APP_BAR_START,
      backgroundColorEnd: AppColors.APP_BAR_END,
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        },
      ),
      bottom: bottom,
    ));
  }

  @override
  Size get preferredSize =>
      Size.fromHeight((height ?? 1) * kToolbarHeight);
}
