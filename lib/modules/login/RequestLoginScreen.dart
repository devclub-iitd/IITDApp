import 'package:IITDAPP/modules/login/LoginScreen.dart';
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
      appBar: CustomAppBar(title: Text(widget.tag),),
      drawer: AppDrawer(tag: widget.tag,),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 28.0),
              child: Text(
                'You need to login to continue',
                style: TextStyle(fontSize: 18),
              ),
            ),
            FlatButton(
              onPressed: ()  {
                // getToken();
                Navigator.pushReplacementNamed(context, LoginScreen.routeName);


              },
              color: Colors.indigo[400],
              child: Text(
                'LOGIN NOW',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

