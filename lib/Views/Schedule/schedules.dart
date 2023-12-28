import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:showops/Views/Schedule/addSchedule.dart';

class SchedulesView extends StatefulWidget {
  @override
  _SchedulesViewState createState() => _SchedulesViewState();
}

class _SchedulesViewState extends State<SchedulesView> {
  DateTime selectedTime = DateTime.now();
  DateTime selectedDate = DateTime.now();
  List<Schedule> Schedules = [
    Schedule(
        time: DateTime.now(),
        title: 'Breakfast',
        label: 'Green Room',
        location: ''),
    Schedule(
        time: DateTime.now().add(Duration(hours: 1)),
        title: 'Load In',
        label: 'Trailers',
        location: ''),
    Schedule(
        time: DateTime.now().add(Duration(hours: 2)),
        title: 'Lunch',
        label: 'Green Room',
        location: ''),
    Schedule(
        time: DateTime.now().add(Duration(hours: 3)),
        title: 'Soundcheck',
        label: 'Stage',
        location: ''),
    Schedule(
        time: DateTime.now().add(Duration(hours: 4)),
        title: 'Radio Interview',
        label: 'Bus',
        location: ''),
    Schedule(
        time: DateTime.now().add(Duration(hours: 5)),
        title: 'Dinner',
        label: 'Green Room',
        location: ''),
    Schedule(
        time: DateTime.now().add(Duration(hours: 6)),
        title: 'Meet & Greet',
        label: 'Lobby',
        location: ''),
    Schedule(
        time: DateTime.now().add(Duration(hours: 7)),
        title: 'Showtime',
        label: 'Stage',
        location: ''),
  ];

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.black, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.black, // body text color
            ),
            dialogBackgroundColor:
                Colors.white, // background color of the dialog
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  String formatDate(DateTime date) {
    return DateFormat('yMMMMd').format(date);
  }

  String getTime(DateTime time) {
    return DateFormat('hh:mm').format(time);
  }

  String getAmPm(DateTime time) {
    return DateFormat('a').format(time);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    double titleFontSize = width < 600 ? 16 : 18;
    double subtitleFontSize = width < 600 ? 14 : 16;
    double timeFontSize = width < 600 ? 18 : 20; // Increased font size

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_left),
                    onPressed: () {
                      setState(() {
                        selectedDate = selectedDate.subtract(Duration(days: 1));
                      });
                    },
                  ),
                  TextButton(
                    onPressed: () => _selectDate(context),
                    style: TextButton.styleFrom(
                      primary:
                          Colors.grey[800], // Setting text color to dark grey
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    ),
                    child: Text(
                      formatDate(selectedDate),
                      style: TextStyle(
                        fontSize: titleFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_right),
                    onPressed: () {
                      setState(() {
                        selectedDate = selectedDate.add(Duration(days: 1));
                      });
                    },
                  ),
                ],
              ),
              Positioned(
                right: 0,
                child: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    // TODO: Implement the action for the Add button
                    Navigator.push(
                      context,
                      // initiate invoke to promoters view
                      MaterialPageRoute(
                          builder: (context) => AddSchedule(
                                isAdmin: true,
                              )),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 5),
        Expanded(
          child: ListView.separated(
            itemCount: Schedules.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {},
                child: ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        getTime(Schedules[index].time),
                        style: TextStyle(
                          fontSize: timeFontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        getAmPm(Schedules[index].time),
                        style: TextStyle(
                          fontSize: timeFontSize -
                              4, // Reduced this a little to differentiate from the time
                        ),
                      ),
                    ],
                  ),
                  title: Text(
                    Schedules[index].title,
                    style: TextStyle(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    Schedules[index].label,
                    style: TextStyle(fontSize: subtitleFontSize),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Divider(color: Colors.grey);
            },
          ),
        ),
      ],
    );
  }
}

class Schedule {
  final DateTime time;
  final String title;
  final String label;
  final String location;

  Schedule({
    required this.time,
    required this.title,
    required this.label,
    required this.location,
  });
}
