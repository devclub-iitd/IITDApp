import 'package:flutter/material.dart';

import 'package:IITDAPP/values/colors/colors.dart';

class SectionHeading extends StatelessWidget {
  const SectionHeading({
    Key key,
    this.text,
    this.onTap,
  }) : super(key: key);

  final String text;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            text,
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 25,
                color: AppColors.SECTION_HEADING_COLOR),
          ),
          RaisedButton(
            color: AppColors.RAISED_BUTTON_COLOR,
            child: Text('More', style: TextStyle(color: AppColors.RAISED_BUTTON_TEXT_COLOR)),
            highlightColor: AppColors.RAISED_BUTTON_TEXT_COLOR,
            onPressed: onTap,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: AppColors.RAISED_BUTTON_TEXT_COLOR)),
          )
        ],
      ),
    );
  }
}
