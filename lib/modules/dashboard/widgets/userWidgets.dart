import 'package:IITDAPP/ThemeModel.dart';
import 'package:IITDAPP/routes/Routes.dart';
import 'package:IITDAPP/values/Constants.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';

class UserEmail extends StatelessWidget {
  const UserEmail({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      height: MediaQuery.of(context).size.height * 0.02,
      child: AutoSizeText(
        // 'kadir.corekci@gmail.com',
        currentUser.email,
        style: TextStyle(
            fontSize: 500,
            color: Provider.of<ThemeModel>(context).theme.PRIMARY_TEXT_COLOR),
      ),
    );
  }
}

class UserName extends StatelessWidget {
  const UserName({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.05,
      child: AutoSizeText(
        currentUser.name ?? 'Unnamed',
        // 'Kadir Corekci',
        style: TextStyle(
            fontSize: 500,
            color: Provider.of<ThemeModel>(context).theme.PRIMARY_TEXT_COLOR),
      ),
    );
  }
}

class UserImage extends StatelessWidget {
  const UserImage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(40),
      child: CircleAvatar(
        backgroundImage:
            NetworkImage('https://randomuser.me/api/portraits/men/26.jpg'),
        radius: MediaQuery.of(context).size.width / 5,
      ),
    );
  }
}

class SignOutButton extends StatelessWidget {
  const SignOutButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: FlatButton(
        child: Text(
          'SIGN OUT',
        ),
        onPressed: () async {
          final storage = FlutterSecureStorage();
          await storage.delete(key: 'email');
          await storage.delete(key: 'password');
          await storage.delete(key: 'token');
          var ls = LocalStorage('iitapp');
          currentUser = null;
          await ls.clear().then((value) =>
              Navigator.pushReplacementNamed(context, Routes.loginPage));
        },
        textColor: Theme.of(context).accentColor,
      ),
    );
  }
}
