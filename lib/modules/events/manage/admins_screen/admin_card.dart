import 'package:IITDAPP/modules/login/user_class.dart';
import 'package:IITDAPP/values/colors/Constants.dart';
import 'package:IITDAPP/widgets/error_alert.dart';
import 'package:IITDAPP/widgets/loading.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

import 'package:IITDAPP/modules/events/globals.dart';

class AdminCard extends StatelessWidget {
  final Admin admin;

  AdminCard(this.admin, Key key) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0x22AAAAAA),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AutoSizeText(
                    admin.name,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                    maxLines: 1,
                  ),
                AutoSizeText(
                    admin.email,
                    style: TextStyle(color: Colors.white),
                    maxLines: 1,
                  ),
              ],
            ),
          ),
          ResponseIcons(admin),
        ],
      ),
    );
  }
}

class ResponseIcons extends StatefulWidget {
  final Admin admin;

  ResponseIcons(this.admin);

  @override
  State<StatefulWidget> createState() {
    return ResponseIconsState();
  }
}

class ResponseIconsState extends State<ResponseIcons> {
  String state;
  Admin admin;

  @override
  void initState() {
    super.initState();
    admin = widget.admin;
    state = 'pending';
  }

  Future<Null> deleteAdmin() async {
    final response = await http.post('$url/api/users/removeAdmin', headers: {
      'authorization': 'Bearer $token'
    }, body: {
      'clubId': currentUser.superAdminOf[0].id,
      'userEmail': admin.email,
    });
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      Navigator.pop(context);
      setState(() {
        state = 'deleted';
      });
    } else {
      Navigator.pop(context);
      showErrorAlert(context, 'Failed', 'Some error occcured. Please try again.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return (state == 'pending')
        ? PopupMenuButton<String>(
            icon: Icon(
              Icons.more_vert,
              color: Colors.white70,
            ),
            onSelected: (a) => _showAlert(context),
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: '',
                child: Text('Remove admin'),
              )
            ],
          )
        : Container(
            child: Center(
              child: Text(
                'removed',
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
            ),
          );
  }

  void _showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.indigo,
          title: Text(
            'Remove Admin',
            style: TextStyle(color: Colors.white),
          ),
          content: Text(
            'Are you sure you want to remove this admin?',
            style: TextStyle(color: Colors.white),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'CANCEL',
                style: TextStyle(color: Colors.white70),
              ),
            ),
            FlatButton(
              onPressed: () async {
                Navigator.pop(context);
                showLoading(context);
                await deleteAdmin();
              },
              child: Text(
                'YES',
                style: TextStyle(color: Colors.white70),
              ),
            )
          ],
        );
      },
    );
  }
}
