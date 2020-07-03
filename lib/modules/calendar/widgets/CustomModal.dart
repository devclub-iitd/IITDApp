part of event_calendar;

// ignore: must_be_immutable
class CustomModal extends StatefulWidget {
  CustomModal(this.func, this.viewType, this.agenda, this.calendarModel,
      this.changeExemption, this.exemptionList);
  var func;
  var changeExemption;
  var viewType;
  var agenda;
  var calendarModel;
  var exemptionList;
  @override
  _CustomModalState createState() => _CustomModalState();
}

// ignore: must_be_immutable
class _CustomModalState extends State<CustomModal> {
  var _viewType;
  var agenda;
  var calDict;
  var exempted;
  var expandedPanelsList;

  List<Map<String, Object>> initializeCalendars(var cal) {
    var res = <String, List>{};
    var expanList = <String, bool>{};
    var exempt = <String, bool>{};
    cal.forEach((data) {
      if (res[data.accountName] == null) {
        res[data.accountName] = [];
        expanList[data.accountName] = false;
      }
      res[data.accountName].add(data);
      exempt[data.name] = false;
    });
    return [res, exempt, expanList];
  }

  @override
  void initState() {
    var temp = initializeCalendars(widget.calendarModel);
    calDict = temp[0];
    exempted =
        widget.exemptionList.length == 0 ? temp[1] : widget.exemptionList;
    expandedPanelsList = temp[2];
    _viewType = widget.viewType;
    if (widget.viewType == CalendarView.month && widget.agenda) {
      _viewType = 0;
    }
    super.initState();
  }

  void changeExempted(var key, bool value) {
    setState(() {
      exempted[key] = !value;
      widget.changeExemption(exempted);
    });
  }

  void changeViewType(var view) {
    setState(() {
      _viewType = view;
    });
  }

  @override
  Widget build(BuildContext context) {
    var dropdownLis = {
      'Day': CalendarView.day,
      'Week': CalendarView.week,
      'Work Week': CalendarView.workWeek,
      'Agenda View': 0,
      'Month': CalendarView.month,
      'Timeline Day': CalendarView.timelineDay,
      'Timeline Week': CalendarView.timelineWeek,
      'Timeline WorkWeek': CalendarView.timelineWorkWeek
    };
    // ignore: non_constant_identifier_names
    DropdownMenuItem CustomDropDownItem(text, value) {
      return DropdownMenuItem(
        child: Text(
          text,
          style: TextStyle(
            color: Provider.of<ThemeModel>(context).theme.ACCENT_TEXT_COLOR,
          ),
        ),
        value: value,
      );
    }

    return Material(
      child: Container(
        height: 500,
        padding: EdgeInsets.all(8),
        // color: Color.fromARGB(255, 240, 240, 240),
        color: Color.fromARGB(255, 35, 39, 51),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Settings',
              style: TextStyle(
                  color:
                      Provider.of<ThemeModel>(context).theme.ACCENT_TEXT_COLOR,
                  fontSize: 23,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 24.0, horizontal: 24),
              child: Row(
                children: <Widget>[
                  Text(
                    'Calendar View',
                    style: TextStyle(
                      fontSize: 21,
                      color: Provider.of<ThemeModel>(context)
                          .theme
                          .ACCENT_TEXT_COLOR,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: DropdownButton(
                      value: _viewType,
                      // dropdownColor: Color.fromARGB(255, 230, 230, 230),
                      dropdownColor: Color.fromARGB(255, 35, 39, 51),
                      items: <DropdownMenuItem<dynamic>>[
                        for (MapEntry e in dropdownLis.entries)
                          CustomDropDownItem(e.key, e.value)
                      ],
                      onChanged: (value) {
                        print(_viewType);
                        widget.func(value);
                        changeViewType(value);
                        print(value);
                      },
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Filter',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color:
                      Provider.of<ThemeModel>(context).theme.ACCENT_TEXT_COLOR,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(),
                    for (MapEntry e in calDict.entries)
                      GestureDetector(
//                      key: Key(widget._calendars[index].isReadOnly
//                          ? 'readOnlyCalendar${widget._readOnlyCalendars.indexWhere((c) => c.id == widget._calendars[index].id)}'
//                          : 'writableCalendar${widget._writableCalendars.indexWhere((c) => c.id == widget._calendars[index].id)}'),
                          child: ExpandableNotifier(
                        controller: ExpandableController(
                            initialExpanded: expandedPanelsList[e.key]),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                ExpandablePanel(
                                  theme: const ExpandableThemeData(
                                    headerAlignment:
                                        ExpandablePanelHeaderAlignment.center,
                                    tapBodyToExpand: true,
                                    tapBodyToCollapse: false,
                                    hasIcon: false,
                                  ),
                                  header: Builder(builder: (context) {
                                    return Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(e.key,
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color:
                                                        Provider.of<ThemeModel>(
                                                                context)
                                                            .theme
                                                            .ACCENT_TEXT_COLOR,
                                                  )),
                                            ),
                                            Spacer(),
                                            ExpandableIcon(
                                              theme: const ExpandableThemeData(
                                                expandIcon: Icons.arrow_right,
                                                collapseIcon:
                                                    Icons.arrow_downward,
                                                iconColor: Colors.white,
                                                iconSize: 28.0,
                                                iconRotationAngle: math.pi / 2,
                                                iconPadding:
                                                    EdgeInsets.only(right: 5),
                                                hasIcon: false,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                                  expanded: Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Column(
                                      children: <Widget>[
                                        for (var data in e.value)
                                          Row(
                                            children: <Widget>[
                                              Container(
                                                height: 20,
                                                width: 20,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                    color: Color(data.color)),
                                              ),
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 12.0),
                                                  child: Text(
                                                    data.name,
                                                  )),
                                              Spacer(),
                                              Checkbox(
                                                value: !exempted[data.name],
                                                onChanged: (bool value) {
                                                  expandedPanelsList[e.key] =
                                                      true;
                                                  changeExempted(
                                                      data.name, value);
                                                },
                                                checkColor: Colors.white,
                                                activeColor: Color(data.color),
                                              )
                                            ],
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
