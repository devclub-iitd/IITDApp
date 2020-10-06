import 'dart:convert';

import 'package:IITDAPP/ThemeModel.dart';
import 'package:IITDAPP/widgets/sectionTitle.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:provider/provider.dart';
import '../dashboard/widgets/errorWidget.dart';
import 'package:http/http.dart' as http;

class ReleaseNotes extends StatefulWidget {
  @override
  _ReleaseNotesState createState() => _ReleaseNotesState();
}

class _ReleaseNotesState extends State<ReleaseNotes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Provider.of<ThemeModel>(context).theme.SCAFFOLD_BACKGROUND,
      appBar: GradientAppBar(
        title: Text('Release Notes'),
        backgroundColorStart:
            Provider.of<ThemeModel>(context).theme.APP_BAR_START,
        backgroundColorEnd: Provider.of<ThemeModel>(context).theme.APP_BAR_END,
      ),
      body: FutureBuilder(
        builder: (_, AsyncSnapshot<List<String>> as) {
          if (as.hasError) {
            return ErrorDisplay(
                refresh: () => setState(() {}), error: as.error.toString());
          }
          if (!as.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: 11,
            itemBuilder: (_, i) {
              if (i == 0) {
                return Padding(
                  padding: EdgeInsets.all(50),
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          'Release Notes',
                          style: TextStyle(
                              fontSize: Theme.of(context)
                                  .primaryTextTheme
                                  .headline4
                                  .fontSize,
                              color: Provider.of<ThemeModel>(context)
                                  .theme
                                  .PRIMARY_TEXT_COLOR),
                        ),
                        SectionUnderLine(),
                        Padding(padding: EdgeInsets.all(10)),
                        Text(
                          '12/10/2020',
                          style: TextStyle(
                              fontSize: Theme.of(context)
                                  .primaryTextTheme
                                  .headline6
                                  .fontSize,
                              color: Provider.of<ThemeModel>(context)
                                  .theme
                                  .PRIMARY_TEXT_COLOR
                                  .withOpacity(0.8)),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return Padding(
                padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                child: Text(
                  '- ' + as.data[i - 1],
                  maxLines: 1,
                ),
              );
            },
          );
        },
        future: getNotes(),
      ),
    );
  }

  Future<List<String>> getNotes() async {
    print('call');
    return await http
        .get('https://api.github.com/repos/devclub-iitd/IITDApp/commits')
        .then((value) {
      var ans = <String>[
        ...json
            .decode(value.body.toString())
            .map((c) => c['commit']['message'].toString())
      ];
      print(ans.length);
      return ans;
    });
  }
}
