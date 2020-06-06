import 'package:IITDAPP/modules/login/user_class.dart';
import 'package:IITDAPP/modules/login/userlogin/signup_page.dart';
import 'package:IITDAPP/values/colors/Constants.dart';
import 'package:IITDAPP/widgets/error_alert.dart';
import 'package:IITDAPP/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pedantic/pedantic.dart';
import 'dart:async';
import 'dart:convert';
import 'package:validators/validators.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


Future login(BuildContext context, String _email, String _password,
    Function onlogin, {bool pop = true}) async {
  print('loggin in');
  final response = await http
      .post('$url/api/login', body: {'email': _email, 'password': _password});
  print('response code ${response.statusCode}');
  if (response.statusCode == 200) {
    Map<String, dynamic> parsedJson = json.decode(response.body);
    if (parsedJson.containsKey('errors')) {
      print('Code 200 but has errors');
      if(pop) Navigator.pop(context);
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Wrong email id or password. Try Again'),
      ));
      return;
    }
    if (parsedJson['message'] == 'Login Successful') {
      final storage = FlutterSecureStorage();
      token = parsedJson['data']['token'];
      final response = await http
          .get('$url/api/user/me', headers: {'authorization': 'Bearer $token'});
      if (response.statusCode == 200) {
        var parsedJson = json.decode(response.body);
        currentUser = User.fromJson(parsedJson['data']);
        print('Login successful');
        print('token : $token');
        await storage.write(key: 'email', value: _email);
        await storage.write(key: 'password', value: _password);
        await storage.write(key: 'token', value: token);
        if(pop) Navigator.pop(context);
        onlogin();
      } else {
        print('Could not get user info.');
        if(pop) Navigator.pop(context);
        await showErrorAlert(context, 'Login Failed', 'Something went wrong. Please Try Again');
      }
    }
  } else if (response.statusCode == 500 || response.statusCode==400) {
    print('wrong email/pass');
    if(pop) Navigator.pop(context);
    await showErrorAlert(context, 'Login Failed', 'Wrong email id or password. Try Again');
  } else {}
}

class LoginPage extends StatefulWidget {
  final Function onlogin;

  LoginPage({this.onlogin});

  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  final _key = GlobalKey<FormState>();
  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[600],
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        behavior: HitTestBehavior.opaque,
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontWeight: FontWeight.w200),
                  ),
                  SizedBox(
                    height: 150,
                  ),
                  Form(
                    key: _key,
                    child: Wrap(
                      // direction: Axis.vertical,
                      alignment: WrapAlignment.center,
                      // crossAxisAlignment: WrapCrossAlignment.center,
                      runSpacing: 9,
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            labelText: 'email-id',
                            helperText: '',
                            enabled: true,
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.04),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.white30)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Colors.white)),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Colors.red[700])),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Colors.white)),
                          ),
                          style: TextStyle(color: Colors.white),
                          onSaved: (text) {
                            _email = text;
                          },
                          validator: (text) {
                            if (text.isEmpty) {
                              return 'Required';
                            } else if (isEmail(text)) {
                              return null;
                            } else {
                              return 'Not a valid e-mail';
                            }
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            labelText: 'Password',
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.04),
                            helperText: '',
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.white30)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Colors.white)),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Colors.red[700])),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Colors.white)),
                          ),
                          obscureText: true,
                          style: TextStyle(color: Colors.white),
                          onSaved: (text) {
                            _password = text;
                          },
                          validator: (text) {
                            return (text.isEmpty) ? 'Required' : null;
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: FlatButton(
                      child: Text('LOGIN'),
                      color: Colors.indigo[400],
                      onPressed: () async {
                        if (_key.currentState.validate()) {
                          _key.currentState.save();
                          unawaited(showLoading(context));
                          await login(
                              context, _email, _password, widget.onlogin);
                          // widget.onlogin();
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Divider(
                            color: Colors.white70,
                            height: 30,
                          ),
                        ),
                        Text(
                          ' OR ',
                          style: TextStyle(wordSpacing: 10),
                        ),
                        Expanded(
                          child: Divider(
                            color: Colors.white70,
                            height: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: FlatButton(
                      child: Text('SIGN UP'),
                      color: Colors.blueAccent,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SignUpPage(widget.onlogin)));
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0),
                    child: InkWell(
                      onTap: () {
                        guest = true;
                        widget.onlogin();
//                          Navigator.push(
//                              context,
//                              MaterialPageRoute(
//                                  builder: (context) =>
//                                      SignUpPage(widget.onlogin)));
                      },
                      child: Text(
                        'Continue as Guest',
                        style: TextStyle(fontSize: 18,color: Colors.white70,),

                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  // return Text("loading");
  // },
  // );
  // }
}
