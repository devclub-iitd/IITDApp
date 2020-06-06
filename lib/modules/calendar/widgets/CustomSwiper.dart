part of event_calendar;

// ignore: must_be_immutable
class CustomSwiper extends StatefulWidget {
  CustomSwiper(this.currDate, this.events);
  var currDate;
  var events;
  @override
  _CustomSwiperState createState() => _CustomSwiperState();
}

class _CustomSwiperState extends State<CustomSwiper> {
  var currDate;
  var compEvents;
  var events = [];
  var dates = [];
  var prevIndex = 0;
  void changeIdxAndDate(bool forward, idx) {
    setState(() {
      prevIndex = idx;
      currDate = currDate.add(Duration(days: forward ? 1 : -1));
    });
  }

  @override
  void initState() {
    compEvents = widget.events;
    currDate = widget.currDate;
    dates.add(widget.currDate);
    events.add(getEventsInRange(widget.events.appointments, dates[0]));
    dates.add(widget.currDate.add(Duration(days: 1)));
    events.add(getEventsInRange(widget.events.appointments, dates[1]));
    dates.add(widget.currDate.add(Duration(days: 2)));
    events.add(getEventsInRange(widget.events.appointments, dates[2]));
    dates.add(widget.currDate.subtract(Duration(days: 2)));
    events.add(getEventsInRange(widget.events.appointments, dates[3]));
    dates.add(widget.currDate.subtract(Duration(days: 1)));
    events.add(getEventsInRange(widget.events.appointments, dates[4]));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Swiper(
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: CustomCard(events[index], dates[index]),
        );
      },
      viewportFraction: 0.8,
      scale: 0.9,
      autoplay: false,
      onIndexChanged: (index) => {
        dates[(prevIndex + 2) % 5] = dates[prevIndex].add(Duration(days: 2)),
        dates[(prevIndex + 3) % 5] =
            dates[prevIndex].subtract(Duration(days: 2)),
        events[(prevIndex + 2) % 5] = getEventsInRange(
            widget.events.appointments,
            dates[prevIndex].add(Duration(days: 2))),
        events[(prevIndex + 3) % 5] = getEventsInRange(
            widget.events.appointments,
            dates[prevIndex].subtract(Duration(days: 2))),
        if (index < prevIndex || (index == 4 && prevIndex == 0))
          changeIdxAndDate(false, index)
        else
          changeIdxAndDate(true, index)
      },
      itemCount: 5,
      scrollDirection: Axis.horizontal,
    );
  }
}

// ignore: must_be_immutable
class CustomCard extends StatefulWidget {
  CustomCard(this.data, this.currDate);
  var data;
  var currDate;
  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    const height = 600.0;
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          heroTag: null,
          onPressed: () async {},
          backgroundColor: Colors.greenAccent,
          child: IconButton(
            onPressed: () {
              _selectedColor = -65535;
              _startDate = widget.currDate;
              _endDate = _startDate.add(Duration(hours: 1));
              _startTime =
                  TimeOfDay(hour: _startDate.hour, minute: _startDate.minute);
              _endTime =
                  TimeOfDay(hour: _endDate.hour, minute: _endDate.minute);
              Navigator.push<Widget>(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => AppointmentEditor()),
              );
            },
            icon: Icon(
              Icons.add,
              size: 25,
            ),
          ),
        ),
        body: Container(
          height: height, // change this
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(height / 20)),
            // color: Color.fromARGB(255, 255, 255, 255),
            color: Color.fromARGB(255, 37, 37, 37)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(height: 10),
              Text(
                '${widget.currDate.day}',
                style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                DateFormat('EEEE').format(widget.currDate), // prints Tuesday
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300),
              ),
              Container(height: 8),
              Divider(
                color: Colors.grey,
              ),
              SingleChildScrollView(
                  child: widget.data.length == 0
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'No events on this date',
                            style:
                                TextStyle(fontSize: 15,),
                          ),
                        )
                      : Column(
                          children: <Widget>[
                            for (var data in widget.data) EventListItem(data)
                          ],
                        ))
            ],
          ),
        ));
  }
}

// ignore: must_be_immutable
class EventListItem extends StatelessWidget {
  EventListItem(this.data);
  var data;
  @override
  Widget build(BuildContext context) {
    var timings = DateFormat('hh:mm').format(data.from) +
        ' - ' +
        DateFormat('hh:mm').format(data.to);
    return InkWell(
      onTap: () {
        _startDate = data.from;
        _endDate = data.to;
        _startTime = TimeOfDay(hour: data.from.hour, minute: data.from.minute);
        _endTime = TimeOfDay(hour: data.to.hour, minute: data.to.minute);
        _isAllDay = data.isAllDay;
        _selectedColor = data.background.value;
        _selectedColorIndex = 0;
        _selectedTimeZoneIndex = 0;
        _subject = data.eventName;
        _notes = data.description;
        _location = data.location;
        _reminder = getReminderString(data.reminder);
        _attendee = getAttendeeString(data.attendee);
        _selectedAppointment = data;
        _recurrence = getRecurrenceString(data.recurrence);
        Navigator.push<Widget>(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => AppointmentEditor()),
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: 12,
                    ),
                    Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: data.background),
                    ),
                    Container(
                      width: 8,
                    ),
                    Text(
                      data.eventName,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    )
                  ],
                ),
                Container(
                  height: 4,
                ),
                Row(
                  children: <Widget>[
                    Container(
                      width: 30,
                    ),
                    Text(
                      timings,
                      style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          fontWeight: FontWeight.w300),
                    )
                  ],
                )
              ],
            ),
            Spacer(),
            data.reminder != null
                ? Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Icon(
                      Icons.notifications,
                      size: 28,
                    ),
                  )
                : Container(),
            data.calendarId == starredCalendarId
                ? Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 28,
                    ),
                  )
                : Container(),
//          IconButton(
//              icon: Icon(
//            Icons.edit,
//            color: Colors.white70,
//          ))
          ],
        ),
      ),
    );
  }
}
