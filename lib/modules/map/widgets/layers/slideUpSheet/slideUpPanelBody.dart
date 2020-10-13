import 'package:IITDAPP/utility/UrlHandler.dart';

import 'package:IITDAPP/ThemeModel.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class SlideUpPanelBody extends StatelessWidget {
  const SlideUpPanelBody(
      {Key key, @required this.locationDetails, @required this.sc})
      : super(key: key);

  final locationDetails;
  final ScrollController sc;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: 10, right: 10, top: MediaQuery.of(context).size.height * 0.15),
      child: ListView(
        controller: sc,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              locationDetails.details ??
                  'Maecenas odio tortor, convallis sit amet sagittis at, ultrices a urna. Praesent maximus quam elementum augue pellentesque, ut dapibus leo feugiat. Praesent quam dolor, aliquam in eros quis, venenatis fermentum nulla. Maecenas finibus, sem ut ornare varius, nisi nulla placerat lorem, ut pellentesque metus libero posuere mauris. Ut sed massa elit. Cras quis urna et dui eleifend maximus. Suspendisse vitae velit sodales, malesuada tellus vitae, viverra erat. Nam ut dui et est volutpat congue ut ut neque. ',
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 17,
                  color: Provider.of<ThemeModel>(context)
                      .theme
                      .PRIMARY_TEXT_COLOR
                      .withOpacity(0.6)),
            ),
          ),
          Divider(
            thickness: 1,
            height: 10,
          ),
          if (locationDetails.openTime != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    'Opens at ' + timeToString(locationDetails.openTime),
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Provider.of<ThemeModel>(context)
                            .theme
                            .PRIMARY_TEXT_COLOR
                            .withOpacity(0.54)),
                  ),
                  Text(
                    'Closes at ' + timeToString(locationDetails.closeTime),
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Provider.of<ThemeModel>(context)
                            .theme
                            .PRIMARY_TEXT_COLOR
                            .withOpacity(0.54)),
                  ),
                ],
              ),
            ),
          Divider(
            thickness: 1,
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                if (locationDetails.link != null)
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Provider.of<ThemeModel>(context)
                            .theme
                            .SLIDE_UP_SHEET_BUTTON_COLOR),
                    child: IconButton(
                      icon: Icon(Icons.link, color: Colors.black),
                      onPressed: () {
                        UrlHandler.launchInBrowser(locationDetails.link);
                      },
                      color: Provider.of<ThemeModel>(context)
                          .theme
                          .SLIDE_UP_SHEET_BUTTON_COLOR,
                    ),
                  ),
                if (locationDetails.contact != null)
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Provider.of<ThemeModel>(context)
                            .theme
                            .SLIDE_UP_SHEET_BUTTON_COLOR),
                    child: IconButton(
                      icon: Icon(
                        Icons.phone,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        UrlHandler.makePhoneCall(locationDetails.contact);
                      },
                      color: Provider.of<ThemeModel>(context)
                          .theme
                          .SLIDE_UP_SHEET_BUTTON_COLOR,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String timeToString(TimeOfDay t) {
    return t.hour.toString().padLeft(2, '0') +
        ':' +
        t.minute.toString().padLeft(2, '0');
  }
}
