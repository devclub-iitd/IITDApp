import 'package:IITDAPP/ThemeModel.dart';
import 'package:IITDAPP/modules/about/privacyPolicy.dart';
import 'package:IITDAPP/modules/about/releaseNotes.dart';
import 'package:IITDAPP/modules/settings/widgets/SettingsTextWidgets.dart';
import 'package:IITDAPP/utility/UrlHandler.dart';
import 'package:IITDAPP/values/Constants.dart';
//import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Provider.of<ThemeModel>(context).theme.SCAFFOLD_BACKGROUND,
      appBar: AppBar(
        //GradientAppBar
        title: Text('About'),
        backgroundColor: Provider.of<ThemeModel>(context).theme.APP_BAR_START,
        //backgroundColorEnd: Provider.of<ThemeModel>(context).theme.APP_BAR_END,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 80, 0, 0),
            child: Center(
              child: Column(children: [
                RichText(
                    text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: 'IITD',
                      style: TextStyle(
                          fontSize: Theme.of(context)
                              .primaryTextTheme
                              .headline2
                              .fontSize,
                          fontWeight: FontWeight.w900,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.teal
                              : Colors.indigo),
                    ),
                    TextSpan(
                        text: 'App',
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: Theme.of(context)
                              .primaryTextTheme
                              .headline2
                              .fontSize,
                          color: Provider.of<ThemeModel>(context)
                              .theme
                              .PRIMARY_TEXT_COLOR,
                        )),
                  ],
                )),
                Padding(padding: EdgeInsets.all(10)),
                Text(version,
                    style: TextStyle(
                      fontSize:
                          Theme.of(context).primaryTextTheme.headline6.fontSize,
                    ))
              ]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Column(
              children: [
                SettingsTextButton(
                  text: 'Release Notes',
                  subtitle: '12/10/2020',
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                      return ReleaseNotes();
                    }));
                  },
                ),
                SettingsTextButton(
                  text: 'Privacy Policy',
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                      return PrivacyPolicy();
                    }));
                  },
                ),
                SettingsTextButton(
                  text: 'Contact',
                  subtitle: 'DevClub',
                  onTap: () {
                    UrlHandler.startEmail('devclub.iitd@gmail.com');
                  },
                ),
                SettingsTextButton(
                  text: 'Feedback',
                  onTap: () {
                    UrlHandler.startEmail('devclub.iitd@gmail.com',
                        subject: 'App Feedback', body: 'App Version $version');
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
