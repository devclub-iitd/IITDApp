import 'package:IITDAPP/ThemeModel.dart';
import 'package:IITDAPP/modules/dashboard/widgets/errorWidget.dart';
import 'package:IITDAPP/modules/news/data/newsData.dart';
import 'package:IITDAPP/modules/news/screens/reports/resportsList.dart';
import 'package:IITDAPP/values/Constants.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:provider/provider.dart';

class AllReports extends StatefulWidget {
  @override
  _AllReportsState createState() => _AllReportsState();
}

class _AllReportsState extends State<AllReports> {
  Future<List<NewsModel>> allReports;
  @override
  void initState() {
    allReports = getAllReports();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        backgroundColorStart:
            Provider.of<ThemeModel>(context).theme.APP_BAR_START,
        backgroundColorEnd: Provider.of<ThemeModel>(context).theme.APP_BAR_END,
        title: Text('All Reports'),
      ),
      body: RefreshIndicator(
          child: FutureBuilder(
            future: allReports,
            builder: (_, AsyncSnapshot<List<NewsModel>> as) {
              if (as.hasError) {
                return ErrorDisplay(
                    refresh: refresh, error: as.error.toString());
              }
              if (!as.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Column(children: [
                ...as.data.map((e) => Card(
                      elevation: 5,
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: ListTile(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (_) => ReportsList(e, true))),
                        title: Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 8, 0, 3),
                          child: Text(
                            e.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 8),
                          child: Text(e.sourceName),
                        ),
                        trailing: SizedBox(
                          width: 45,
                          child: Row(
                            children: [
                              Text(e.reports.length.toString()),
                              Icon(Icons.report)
                            ],
                          ),
                        ),
                      ),
                    ))
              ]);
            },
          ),
          onRefresh: refresh),
    );
  }

  Future<List<NewsModel>> getAllReports() async {
    var results =
        (await apiBaseHelper.get('$url/api/news/report/all') as Map)['data'];
    return <NewsModel>[...results.map((i) => NewsModel.fromMap(i)).toList()];
  }

  Future<void> refresh() {
    setState(() {
      allReports = getAllReports();
    });
    return null;
  }
}
