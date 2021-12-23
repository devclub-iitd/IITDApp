import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Heading extends StatelessWidget {
  final String _title;
  final double _size;
  const Heading(this._title, this._size);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
            padding: const EdgeInsets.fromLTRB(20, 15, 0, 10),
            child: Text(
              _title,
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w400, fontSize: _size),
            ))
      ],
    );
  }
}
