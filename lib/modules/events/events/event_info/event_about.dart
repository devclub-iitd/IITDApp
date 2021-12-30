import 'package:IITDAPP/ThemeModel.dart';
import 'package:provider/provider.dart';
import 'package:IITDAPP/widgets/sectionTitle.dart';
import 'package:flutter/material.dart';
import '../event_class.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class EventAbout extends StatelessWidget {
  final Event _event;

  const EventAbout(this._event);

  Future<void> _launch(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print("no");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SectionTitle(
              title: 'ABOUT THE EVENT',
            ),
            SectionUnderLine(),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: SelectableLinkify(
                    onOpen: (url) => {_launch(url.url), print(url)},
                    text: _event.about,
                    style: TextStyle(
                      color: Provider.of<ThemeModel>(context)
                          .theme
                          .PRIMARY_TEXT_COLOR,
                      fontWeight: FontWeight.w300,
                      fontSize: 15,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                // Container(
                //   margin: EdgeInsets.only(bottom: 20),
                //   child: SelectableText(
                //     _event.about,
                //     style: TextStyle(
                //       color: Provider.of<ThemeModel>(context)
                //           .theme
                //           .PRIMARY_TEXT_COLOR,
                //       fontWeight: FontWeight.w300,
                //       fontSize: 15,
                //       letterSpacing: 0.5,
                //     ),
                //   ),
                // ),
              ],
            ),
            Center(child: Image.network(_event.imageLink)),
          ],
        ),
      ),
    );
  }
}
