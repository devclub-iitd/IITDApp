import 'package:IITDAPP/widgets/sectionTitle.dart';
import 'package:flutter/material.dart';

class AttendanceListHeader extends StatelessWidget {
  final String text;
  const AttendanceListHeader(this.text);
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
          padding: const EdgeInsets.only(top: 10, left: 10),
          child: SectionTitle(title: text.toUpperCase())),
      Padding(
          padding: const EdgeInsets.only(left: 10, bottom: 2.5),
          child: SectionUnderLine())
    ]);
  }
}
