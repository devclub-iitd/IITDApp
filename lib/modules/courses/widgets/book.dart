import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:IITDAPP/utility/UrlHandler.dart';

class Book extends StatelessWidget {
  final String _name;
  final String _link;
  Book(this._name, this._link);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        UrlHandler.launchInBrowser(_link);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            //color: Colors.red,
            padding: EdgeInsets.fromLTRB(40, 0, 10, 0),
            child: Text(
              _name.toUpperCase(),
              style: GoogleFonts.dmSans(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
