import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:IITDAPP/ThemeModel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:IITDAPP/modules/courses/data/contentdata.dart';
import 'package:IITDAPP/modules/courses/widgets/book.dart';

class ListCard extends StatelessWidget {
  final String utility;
  final String course;
  ListCard(this.utility, this.course);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Provider.of<ThemeModel>(context).theme.LinksSectionStart,
                  Provider.of<ThemeModel>(context).theme.LinksSectionEnd
                ])),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(40, 5, 0, 5),
              decoration: BoxDecoration(
                color: Provider.of<ThemeModel>(context).theme.LinkSectionHeader,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
              ),
              width: double.infinity,
              child: Text(
                utility.toUpperCase(),
                style:
                    GoogleFonts.robotoMono(fontSize: 30, color: Colors.white),
              ),
            ),
            //Container(height: 10,),
            Container(
              height: 140,
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(),
                      for (var x in (data.containsKey(course.toLowerCase())
                          ? (data[course.toLowerCase()]
                                  .containsKey(utility.toLowerCase())
                              ? data[course.toLowerCase()]
                                  [utility.toLowerCase()]
                              : [])
                          : []))
                        Book(x.name, x.url),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
