import 'package:IITDAPP/modules/news/data/report.dart';
import 'package:IITDAPP/modules/news/widgets/cards/imageOverlay/text/newsDate.dart';

import 'package:IITDAPP/ThemeModel.dart';
import 'package:provider/provider.dart';
import 'package:IITDAPP/widgets/CustomAppBar.dart';
import 'package:flutter/material.dart';

class ReportsList extends StatelessWidget {
  final List<Report> reports;
  ReportsList(this.reports);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Provider.of<ThemeModel>(context).theme.SCAFFOLD_BACKGROUND,
      appBar: CustomAppBar(title: Text('Reports'), withMenu: false),
      body: Container(
        child: (reports.isEmpty)
            ? Center(
                child: Text(
                  'No Reports',
                  style: TextStyle(fontWeight: FontWeight.w200, fontSize: 25),
                ),
              )
            : ListView.builder(
                itemCount: reports.length,
                itemBuilder: (_, i) {
                  return Card(
                    margin: EdgeInsets.all(5),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          NewsDate(
                            createdAt:
                                reports[reports.length - i - 1].reportedAt,
                            size: 13,
                            color:
                                Theme.of(context).accentColor.withOpacity(0.7),
                          ),
                          const Divider(),
                          Text(
                            reports[reports.length - i - 1].description,
                            style: Theme.of(context)
                                .primaryTextTheme
                                .bodyText1
                                .copyWith(
                                    fontSize: 15, fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
      ),
    );
  }
}
