import 'package:IITDAPP/modules/login/user_class.dart';
import 'package:IITDAPP/values/Constants.dart';

import 'package:IITDAPP/ThemeModel.dart';
import 'package:provider/provider.dart';
import 'package:IITDAPP/widgets/error_alert.dart';
import 'package:IITDAPP/widgets/loading.dart';
import 'package:flutter/material.dart';
//import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:IITDAPP/modules/events/manage/admins_screen/admins_list.dart';
import 'package:pedantic/pedantic.dart';

Future<List<Admin>> getAdmins() async {
  print('Getting Admins');
  final response = await http.post('$url/api/users/getAdmins',
      headers: {'authorization': 'Bearer $token'},
      body: {'clubId': currentUser.superAdminOf[0].id});
  print(response.statusCode);
  if (response.statusCode == 200) {
    print('afdv');
    var parsedJson = json.decode(response.body);
    // ignore: prefer_collection_literals
    var admins = List<Admin>();
    for (var i = 0; i < parsedJson['data']['admins'].length; i++) {
      var r = Admin.fromJson(parsedJson['data']['admins'][i]);
      print('qwerty');
      admins.add(r);
    }
    admins.sort((a, b) {
      return (a.name != b.name)
          ? a.name.compareTo(b.name)
          : a.email.compareTo(b.email);
    });
    return admins;
  } else {
    throw Exception('Could not get admins');
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
      backgroundColor:
          Provider.of<ThemeModel>(context).theme.SCAFFOLD_BACKGROUND,
      appBar: AppBar(
        backgroundColor: Provider.of<ThemeModel>(context).theme.APP_BAR_START,
        //backgroundColorEnd: Provider.of<ThemeModel>(context).theme.APP_BAR_END,
        title: Text('${currentUser.superAdminOf[0].clubName} Admins'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(15),
            child: FlatButton(
              color: Provider.of<ThemeModel>(context)
                  .theme
                  .RAISED_BUTTON_BACKGROUND,
              onPressed: () async {
                _showAlert(context);
              },
              child: Text(
                'ADD NEW ADMIN',
                style: TextStyle(
                    color: Provider.of<ThemeModel>(context)
                        .theme
                        .RAISED_BUTTON_FOREGROUND),
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
                      child: Text(
                        'Some Error Occured',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ));
              }

              return Center(
                child: CircularProgressIndicator(
                    // valueColor: AlwaysStoppedAnimation<Color>(
                    //     Provider.of<ThemeModel>(context,listen:false).theme.PRIMARY_TEXT_COLOR),
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
    print('Adding Admin');
    final response = await http.post('$url/api/users/addAdmin',
        headers: {'authorization': 'Bearer $token'},
        body: {'userEmail': email, 'clubId': currentUser.superAdminOf[0].id});
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      Navigator.pop(context);
      Navigator.pop(context);
      widget.refresh();
    } else {
      Navigator.pop(context);
      await showErrorAlert(context, 'Failed',
          'Some error occured. Check user email and try again');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: AlertDialog(
        backgroundColor: Provider.of<ThemeModel>(context).theme.ALERT_DIALOG,
        title: Text(
          'Add a ${currentUser.superAdminOf[0].clubName} admin',
          style: TextStyle(
              color: Provider.of<ThemeModel>(context).theme.ALERT_DIALOG_TEXT),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Enter the email of the user and the club you want to make the user admin of.',
              style: TextStyle(
                  color:
                      Provider.of<ThemeModel>(context).theme.ALERT_DIALOG_TEXT),
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
                    style: TextStyle(
                        color: Provider.of<ThemeModel>(context)
                            .theme
                            .ALERT_DIALOG_TEXT),
                    onSaved: (text) {
                      email = text;
                    },
                    validator: (text) {
                      if (text.isEmpty) {
                        return 'Required';
                      } else if (text == currentUser.email) {
                        return 'You already have Admin access';
                      } else {
                        return null;
                      }
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
              style: TextStyle(
                  color: Provider.of<ThemeModel>(context)
                      .theme
                      .ALERT_DIALOG_TEXT
                      .withOpacity(0.7)),
            ),
          ),
          FlatButton(
            onPressed: () async {
              if (_key.currentState.validate()) {
                _key.currentState.save();
                unawaited(showLoading(context));
                await addAdmin();
              }
            },
            child: Text(
              'ADD',
              style: TextStyle(
                  color: Provider.of<ThemeModel>(context)
                      .theme
                      .ALERT_DIALOG_TEXT
                      .withOpacity(0.7)),
            ),
          )
        ],
      ),
    );
  }
}
