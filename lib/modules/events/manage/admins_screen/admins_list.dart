import 'package:IITDAPP/modules/login/user_class.dart';

import 'package:IITDAPP/ThemeModel.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:IITDAPP/modules/events/manage/admins_screen/admin_card.dart';

class AdminList extends StatefulWidget {
  final List<Admin> admins;

  const AdminList(this.admins);

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
    if (admins.isEmpty) {
      return Center(
        child: Container(
          margin: EdgeInsets.only(top: 20),
          child: Text(
            'No Admins apart from this account',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Provider.of<ThemeModel>(context)
                    .theme
                    .PRIMARY_TEXT_COLOR
                    .withOpacity(0.7)),
          ),
        ),
      );
    }
    return Column(
      children: admins
          .map((element) => AdminCard(element, ValueKey(element.id)))
          .toList(),
    );
  }
}
