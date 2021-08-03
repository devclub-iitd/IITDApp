import 'package:IITDAPP/ThemeModel.dart';
import 'package:IITDAPP/modules/login/LoginStateProvider.dart';
import 'package:IITDAPP/routes/Routes.dart';
import 'package:provider/provider.dart';
//import 'package:IITDAPP/values/colors/Constants.dart';
import 'package:IITDAPP/widgets/CustomAppBar.dart';
import 'package:IITDAPP/widgets/Drawer.dart';
//import 'package:IITDAPP/widgets/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RequestLoginScreen extends StatefulWidget {
  static const String routeName = '/requestLogin';

  RequestLoginScreen(this.tag);
  String tag;
  @override
  _RequestLoginScreenState createState() => _RequestLoginScreenState();
}

class _RequestLoginScreenState extends State<RequestLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Provider.of<ThemeModel>(context).theme.SCAFFOLD_BACKGROUND,
      appBar: CustomAppBar(
        title: Text(widget.tag),
      ),
      drawer: AppDrawer(
        tag: widget.tag,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 28.0),
              child: Text(
                'You need to login to continue',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w300,
                    color: Provider.of<ThemeModel>(context)
                        .theme
                        .PRIMARY_TEXT_COLOR),
              ),
            ),
            TextButton(
              onPressed: () {
                // getToken();
                context.read<LoginStateProvider>().signOut().then((value) =>
                    Navigator.pushReplacementNamed(context, Routes.loginPage));
              },
              style: TextButton.styleFrom(
                backgroundColor: Provider.of<ThemeModel>(context)
                    .theme
                    .RAISED_BUTTON_BACKGROUND,
              ),
              child: Text(
                'LOGIN NOW',
                style: TextStyle(
                    color: Provider.of<ThemeModel>(context)
                        .theme
                        .RAISED_BUTTON_FOREGROUND),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
