import 'package:IITDAPP/modules/news/data/newsData.dart';
import 'package:flutter/material.dart';

class ReportDialog extends StatefulWidget {
  const ReportDialog({
    Key key, this.item,
  }) : super(key: key);

  final NewsModel item;

  @override
  _ReportDialogState createState() => _ReportDialogState();
}

class _ReportDialogState extends State<ReportDialog> {
  final List<bool> _selected = [false, false, false];
  final List<String> _options = ['Fake news', 'Hate speech', 'Spam'];
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 300,
        width: 250,
        child: Card(
          child: Stack(children: [
            Align(
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'Report Article',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Divider(
                    thickness: 2,
                    indent: 10,
                    endIndent: 10,
                  ),
                  ..._options.map((e) => LabeledCheckbox(
                        label: e,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        onChanged: (bool value) {
                          setState(() {
                            _selected[_options.indexOf(e)] = value;
                          });
                        },
                        value: _selected[_options.indexOf(e)],
                      )),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: FlatButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('Cancel')),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: FlatButton(
                    onPressed: () {
                      widget.item.report(_options.where(
                          (element) => _selected[_options.indexOf(element)]).toList());
                      Navigator.of(context).pop();
                    },
                    child: Text('Report')),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class LabeledCheckbox extends StatelessWidget {
  const LabeledCheckbox({
    this.label,
    this.padding,
    this.value,
    this.onChanged,
  });

  final String label;
  final EdgeInsets padding;
  final bool value;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Padding(
        padding: padding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Checkbox(
              value: value,
              onChanged: (bool newValue) {
                onChanged(newValue);
              },
            ),
            Expanded(child: Text(label)),
          ],
        ),
      ),
    );
  }
}
