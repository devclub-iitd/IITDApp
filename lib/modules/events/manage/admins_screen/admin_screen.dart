import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:IITDAPP/modules/events/error_alert.dart';
import 'package:IITDAPP/modules/events/loading.dart';
import 'package:IITDAPP/modules/events/manage/admins_screen/admins_list.dart';

import 'package:IITDAPP/modules/events/globals.dart';
import 'package:IITDAPP/modules/events/user_class.dart';

Future<List<Admin>> getAdmins() async {
  print("Getting Admins");
  final response = await http.post("$url/api/users/getAdmins",
      headers: {"authorization": "Bearer $token"},
      body: {"clubId": currentUser.superAdminOf[0].id});
  print(response.statusCode);
  if (response.statusCode == 200) {
    print("afdv");
    var parsedJson = json.decode(response.body);
    List<Admin> admins = List<Admin>();
    for (int i = 0; i < parsedJson["data"]["admins"].length; i++) {
      Admin r = Admin.fromJson(parsedJson["data"]["admins"][i]);
      print("qwerty");
      admins.add(r);
    }
    admins.sort((a, b) {
      return (a.name != b.name)
          ? a.name.compareTo(b.name)
          : a.email.compareTo(b.email);
    });
    return admins;
  } else {
    throw Exception("Could not get admins");
  }
}

class AdminScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AdminScreenState();
  }
}

class AdminScreenState extends State<AdminScreen> {
  final Future<List<Admin>> admins = getAdmins();

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        backgroundColorStart: Colors.indigo,
        backgroundColorEnd: Colors.cyan,
        title: Text('${currentUser.superAdminOf[0].clubName} Admins'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(15),
            child: FlatButton(
              color: Colors.indigo[400],
              onPressed: () async {
                _showAlert(context);
              },
              child: Text(
                'ADD NEW ADMIN',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          FutureBuilder(
            future: getAdmins(),
            builder: (context, snapshot) {
              if (snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done) {
                return AdminList(snapshot.data);
              } else if (snapshot.hasError) {
                return Container(
                    padding: EdgeInsets.all(50),
                    child: Center(
                      child: Text("Some Error Occured"),
                    ));
              }

              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AddDialog(refresh);
        });
  }
}

class AddDialog extends StatefulWidget {
  final Function refresh;

  AddDialog(this.refresh);

  @override
  State<StatefulWidget> createState() {
    return AddDialogState();
  }
}

class AddDialogState extends State<AddDialog> {
  String email;
  String selectedClub;
  final _key = GlobalKey<FormState>();
  List<DropdownMenuItem<String>> clubList = [];

  Future<Null> addAdmin() async {
    print("Adding Admin");
    final response = await http.post("$url/api/users/addAdmin",
        headers: {"authorization": "Bearer $token"},
        body: {"userEmail": email, "clubId": currentUser.superAdminOf[0].id});
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      Navigator.pop(context);
      Navigator.pop(context);
      widget.refresh();
    } else {
      Navigator.pop(context);
      showErrorAlert(context, "Failed",
          "Some error occured. Check user email and try again");
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: AlertDialog(
        backgroundColor: Colors.indigo,
        title: Text(
          'Add a ${currentUser.superAdminOf[0].clubName} admin',
          style: TextStyle(color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Enter the email of the user and the club you want to make the user admin of.',
              style: TextStyle(color: Colors.white),
            ),
            Form(
              key: _key,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'User Email',
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    style: TextStyle(color: Colors.white),
                    onSaved: (text) {
                      email = text;
                    },
                    validator: (text) {
                      if (text.isEmpty)
                        return 'Required';
                      else if (text == currentUser.email)
                        return 'You already have Admin access';
                      else
                        return null;
                    },
                  ),
                ],
              ),
            )
          ],
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
              if (_key.currentState.validate()) {
                _key.currentState.save();
                showLoading(context);
                await addAdmin();
              }
            },
            child: Text(
              'ADD',
              style: TextStyle(color: Colors.white70),
            ),
          )
        ],
      ),
    );
  }
}
