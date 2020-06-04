import 'package:flutter/material.dart';

import './profile_dialog.dart';

class ProfileIcon extends StatelessWidget {
  final Function onlogout;

  ProfileIcon(this.onlogout);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.person),
      onPressed: () {showAlert(context, onlogout);}
    );
  }
}