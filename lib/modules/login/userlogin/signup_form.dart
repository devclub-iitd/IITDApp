import 'package:IITDAPP/modules/login/userlogin/login_page.dart';
import 'package:IITDAPP/values/colors/Constants.dart';
import 'package:IITDAPP/widgets/cancel_alert.dart';
import 'package:IITDAPP/widgets/error_alert.dart';
import 'package:IITDAPP/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pedantic/pedantic.dart';
import 'package:validators/validators.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class SignUpForm extends StatefulWidget {
  final Function onlogin;

  SignUpForm(this.onlogin);

  @override
  State<StatefulWidget> createState() {
    return _SignUpFormState();
  }
}

class _SignUpFormState extends State<SignUpForm> {
  String name;
  String emailId;
  String password;

  final _key = GlobalKey<FormState>();

  Future makeUser() async {
    print('Signing Up');
    final response = await http.post('$url/api/signup',
        body: {'email': emailId, 'name': name, 'password': password});
    // print(response.body);
    print(response.statusCode);
    if (response.body == 'Username or Email Is Already In Use') {
      Navigator.pop(context);
      await showErrorAlert(context, 'Email already registered',
          'This email is already registered. Use another email.');
      return;
    }
    if (response.statusCode == 200) {
      var parsedJson = json.decode(response.body);
      print('success');
      if (parsedJson['message'] == 'Registration Successful') {
        Navigator.pop(context);
        await showErrorAlert(
            context, 'Success', 'SignUp successful. Press continue to login.',
            command: 'CONTINUE');
        unawaited(showLoading(context));
        await login(context, emailId, password, widget.onlogin);
        Navigator.pop(context);
      } else {
        Navigator.pop(context);
        print('code 200 but error');
        await showErrorAlert(context, 'Sign Up Failed',
            'Please check your details and try again.');
      }
    } else {
      Navigator.pop(context);
      print('error');
      print(response.body);
      await showErrorAlert(context, 'Sign Up Failed',
          'Please check your details and try again.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: _key,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                  alignLabelWithHint: true,
                  labelText: 'Enter Name',
                  helperText: ''),
              keyboardType: TextInputType.multiline,
              maxLines: null,
              style: TextStyle(color: Colors.white),
              onSaved: (text) {
                name = text;
              },
              validator: (text) {
                if (text.isEmpty) {
                  return 'Required';
                } else {
                  return null;
                }
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                  alignLabelWithHint: true,
                  labelText: 'e-mail address',
                  helperText: ''),
              style: TextStyle(color: Colors.white),
              onSaved: (text) {
                emailId = text;
              },
              validator: (text) {
                if (text.isEmpty) {
                  return 'Required';
                } else if (isEmail(text)) {
                  return null;
                } else {
                  return ('Not a valid e-mail id');
                }
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                  alignLabelWithHint: true,
                  labelText: 'Make a Password',
                  helperText: ''),
              onSaved: (text) {
                password = text;
              },
              obscureText: true,
              style: TextStyle(color: Colors.white),
              validator: (text) {
                if (text.isEmpty) {
                  return 'Required';
                } else {
                  return null;
                }
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                  alignLabelWithHint: true,
                  labelText: 'Confirm Password',
                  helperText: ''),
              obscureText: true,
              style: TextStyle(color: Colors.white),
              validator: (text) {
                if (text != password) {
                  return 'Does not match';
                } else {
                  return null;
                }
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    showCancelAlert(context, 'Cancel Sign-Up?',
                        'Are you sure you want to cancel making new account?');
                  },
                  child: Text('CANCEL'),
                  color: Colors.indigo[400],
                ),
                RaisedButton(
                  color: Colors.blueAccent,
                  child: Text(
                    'SUBMIT',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    _key.currentState.save();
                    if (_key.currentState.validate()) {
                      unawaited(showLoading(context));
                      await makeUser();
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
