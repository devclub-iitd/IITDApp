import 'package:IITDAPP/modules/news/data/newsData.dart';

import 'package:IITDAPP/ThemeModel.dart';
import 'package:provider/provider.dart';
import 'package:IITDAPP/widgets/CustomAppBar.dart';
import 'package:flutter/material.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({
    Key key,
    this.item,
  }) : super(key: key);

  final NewsModel item;

  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final List<bool> _selected = [false, false, false];
  final List<String> _options = ['Fake', 'Offensive', 'Spam'];
  final TextEditingController _reportTextController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    _reportTextController.addListener(() {
      if (!_focusNode.hasFocus) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _reportTextController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor:
            Provider.of<ThemeModel>(context).theme.SCAFFOLD_BACKGROUND,
        appBar: CustomAppBar(withMenu: false, title: Text('Report')),
        body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          'What\'s wrong with this article?',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
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
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: TextField(
                          minLines: 1,
                          maxLines: 5,
                          focusNode: _focusNode,
                          keyboardType: TextInputType.text,
                          autocorrect: true,
                          autofocus: false,
                          controller: _reportTextController,
                          decoration: InputDecoration(labelText: 'Other'),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FormButton(
                          text: 'CANCEL',
                          widget: widget,
                        ),
                        FormButton(
                            text: 'REPORT',
                            widget: widget,
                            onPressed: () {
                              if (_reportTextController.text.isEmpty &&
                                  !(_selected
                                      .any((element) => element == true))) {
                                AlertDialog alert = AlertDialog(
                                  title: Text("Empty Report"),
                                  content: Text("Please Choose An Option"),
                                  actions: [],
                                );

                                // show the dialog
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return alert;
                                  },
                                );
                              } else {
                                var results = _options
                                    .where((element) =>
                                        _selected[_options.indexOf(element)])
                                    .toList();
                                results.add(_reportTextController.text);
                                widget.item.report(results).then((value) => {
                                      Navigator.pop(context, value),
                                      Navigator.pop(context)
                                    });
                              }
                            }),
                      ]),
                ),
              ]),
        ),
      ),
    );
  }
}

class FormButton extends StatelessWidget {
  const FormButton({
    Key key,
    @required this.widget,
    this.onPressed,
    @required this.text,
  }) : super(key: key);

  final ReportScreen widget;
  final Function onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextButton(
          onPressed: onPressed,
          child: Text(
            text,
          )),
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
