import 'package:flutter/material.dart';
import 'package:IITDAPP/modules/events/manage/admins_screen/admin_card.dart';

import 'package:IITDAPP/modules/events/user_class.dart';

class AdminList extends StatefulWidget {
  final List<Admin> admins;

  AdminList(this.admins);

  @override
  State<StatefulWidget> createState() {
    return AdminListState();
  }
}

class AdminListState extends State<AdminList> {
  List<Admin> admins;

  @override
  void initState() {
    super.initState();
    admins = widget.admins;
  }

  @override
  Widget build(BuildContext context) {
    if (admins.length == 0) {
      return Center(
        child: Container(
          margin: EdgeInsets.only(top: 20),
          child: Text(
            "No Admins apart from this account",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white70),
          ),
        ),
      );
    }
    return Column(
      children: admins.map((element) => AdminCard(element, ValueKey(element.id))).toList(),
    );
  }
}
