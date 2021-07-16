import 'package:IITDAPP/ThemeModel.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class MarkerLabel extends StatelessWidget {
  const MarkerLabel({
    Key key,
    @required this.y,
    this.color,
    @required this.label,
  }) : super(key: key);

  final double y;
  final Color color;
  final String label;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 20,
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Positioned(
            top: y / 2 + 6,
            child: SizedBox(
                width: 50,
                child: AutoSizeText(
                  label,
                  maxLines: 3,
                  minFontSize: 5,
                  maxFontSize: 10,
                  wrapWords: false,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: color ??
                          Provider.of<ThemeModel>(context)
                              .theme
                              .DEFAULT_LABEL_COLOR),
                )),
          ),
        ],
      ),
    );
  }
}
