import 'package:IITDAPP/ThemeModel.dart';
import 'package:IITDAPP/modules/settings/data/SettingsHandler.dart';
import 'package:IITDAPP/values/Constants.dart';
import 'package:IITDAPP/modules/settings/SettingsScreen.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserEmail extends StatelessWidget {
  const UserEmail({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15, bottom: 30),
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
    return SizedBox(
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
    // Load the avImage from the SettingsHandler

    return Container(
      padding: EdgeInsets.all(40),
      child: CircleAvatar(
        /*backgroundImage: NetworkImage(
            'https://www.nacdnet.org/wp-content/uploads/2016/06/person-placeholder.jpg'),*/
        backgroundImage: AssetImage(avImage),
        radius: MediaQuery.of(context).size.width / 5,
      ),
    );
  }
}
