import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:IITDAPP/modules/events/userlogin/signup_form.dart';

import '../cancel_alert.dart';


class SignUpPage extends StatelessWidget {
  final Function onlogin;

  SignUpPage(this.onlogin);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showCancelAlert(context, 'Cancel Sign-Up?', 'Are you sure you want to cancel making new account?'),
      child: Scaffold(
        appBar: GradientAppBar(
          title: Text('Create New User'),
          centerTitle: true,
          backgroundColorStart: Colors.indigo,
          backgroundColorEnd: Colors.cyan,
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          behavior: HitTestBehavior.opaque,
          child: ListView(
            children: <Widget>[SignUpForm(onlogin)],
          ),
        ),
      ),
    );
  }
}
