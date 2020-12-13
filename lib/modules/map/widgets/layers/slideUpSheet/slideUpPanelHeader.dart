import 'package:IITDAPP/ThemeModel.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class SlideUpPanelHeader extends StatelessWidget {
  const SlideUpPanelHeader({
    Key key,
    @required this.locationDetails,
  }) : super(key: key);

  final locationDetails;

  @override
  Widget build(BuildContext context) {
    var canvasSize = MediaQuery.of(context).size;
    return SizedBox(
      width: canvasSize.width - 10,
      height: canvasSize.height * 0.18,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Provider.of<ThemeModel>(context).theme.SLIDE_UP_SHEET_COLOR,
            borderRadius: BorderRadius.circular(5)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                locationDetails.name,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                    color: Provider.of<ThemeModel>(context)
                        .theme
                        .SLIDE_UP_SHEET_TEXT_COLOR),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 6.0),
              child: Text(
                locationDetails.subtitle ?? 'Landmark',
                style: TextStyle(
                    fontWeight: FontWeight.w200,
                    fontSize: 16,
                    color: Provider.of<ThemeModel>(context)
                        .theme
                        .SLIDE_UP_SHEET_TEXT_COLOR),
              ),
            ),
            Divider(
              thickness: 3,
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}
