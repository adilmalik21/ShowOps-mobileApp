import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showops/Views/Events/EventInsidePage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class EventsView extends StatefulWidget {
  @override
  _EventsViewState createState() => _EventsViewState();
}

class _EventsViewState extends State<EventsView> {
  bool isLoading = false;
  DateTime selectedDate = DateTime.now();
  String? firstName;
  String? lastName;

  Future<void> _loadUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      firstName = prefs.getString('firstName') ?? 'User';
      lastName = prefs.getString('lastName') ?? '';
    });
  }

  List<Event> events = [];

  Future<void> _fetchEvents(
      {String type = 'upcoming', String? startDate, String? endDate}) async {
    setState(() {
      isLoading = true; // Start loading
    });
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    Map<String, dynamic> requestBody = {'type': type};

    if (type == 'date_range' && startDate != null && endDate != null) {
      requestBody.addAll({
        'start_date': startDate,
        'end_date': endDate,
      });
    } else if (type == 'start_date' && startDate != null) {
      requestBody.addAll({
        'start_date': startDate,
      });
    }

    final response = await http.post(
      Uri.parse('https://dev.showops.co/api/events'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse['status'] == 'success') {
        setState(() {
          events = List<Event>.from(
            jsonResponse['data'].map((x) => Event.fromJson(x)),
          );
        });
      }
    } else {
      // Handle error
      print('Failed to load events');
    }
    setState(() {
      isLoading = false; // Stop loading
    });
  }

  void _fetchEventsForTwoMonths() {
    DateTime now = DateTime.now();
    DateTime startDate = DateTime(now.year, now.month, now.day); // Today's date
    DateTime endDate =
        DateTime(now.year, now.month + 2, now.day); // Two months from today

    String formattedStartDate = DateFormat('yyyy-MM-dd').format(startDate);
    String formattedEndDate = DateFormat('yyyy-MM-dd').format(endDate);

    // print(
    //     "printing formated start date: $formattedStartDate & end date: $formattedEndDate");

    _fetchEvents(
        type: 'date_range',
        startDate: formattedStartDate,
        endDate: formattedEndDate);
  }

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

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });

      String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
      _fetchEvents(type: 'start_date', startDate: formattedDate);
    }
  }

  String getMonthName(DateTime date) {
    return DateFormat('MMM').format(date);
  }

  @override
  void initState() {
    super.initState();
    _loadUserDetails();
    _fetchEventsForTwoMonths();
  }

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    double titleFontSize = width < 600 ? 16 : 18;
    double subtitleFontSize = width < 600 ? 14 : 16;
    double monthFontSize = width < 600 ? 14 : 16;
    double dayFontSize = width < 600 ? 18 : 20;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: Text(
            'Welcome, $firstName $lastName.',
            style: TextStyle(
              fontSize: titleFontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Center(
          child: Text(
            'Choose an event to get started!',
            style: TextStyle(
              fontSize: subtitleFontSize,
              color: Colors.grey[700],
            ),
          ),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              child: Text(
                'Upcoming',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontSize: subtitleFontSize,
                ),
              ),
              onTap: () {
                _fetchEvents(type: 'upcoming');
              },
            ),
            SizedBox(width: 8),
            Text('|'),
            SizedBox(width: 8),
            InkWell(
              child: Text(
                'Past',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontSize: subtitleFontSize,
                ),
              ),
              onTap: () {
                _fetchEvents(type: 'past');
              },
            ),
            SizedBox(width: 8),
            Text('|'),
            SizedBox(width: 8),
            InkWell(
              child: Icon(Icons.calendar_today),
              onTap: () {
                _selectDate(context);
              },
            ),
          ],
        ),
        SizedBox(height: 10),
        Expanded(
          child: isLoading
              ? Center(
                  child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xff9dc451)),
                ))
              : ListView.separated(
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                EventInsidePage(eventId: events[index].id),
                          ),
                        );
                      },
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 0.0,
                            horizontal:
                                16.0), // Adjust vertical padding for height
                        leading: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              getMonthName(events[index].startDate)
                                  .toUpperCase(),
                              style: TextStyle(
                                fontSize: monthFontSize,
                              ),
                            ),
                            Text(
                              events[index].startDate.day.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: dayFontSize,
                              ),
                            ),
                          ],
                        ),
                        title: Text(
                          events[index].title,
                          style: TextStyle(
                            fontSize: titleFontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              events[index].venueName,
                              style: TextStyle(fontSize: subtitleFontSize),
                            ),
                            Text(
                              (events[index].city + ", " + events[index].state),
                              style: TextStyle(fontSize: subtitleFontSize - 2),
                            )
                          ],
                        ),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(color: Colors.grey); // Light grey line
                  },
                ),
        ),
      ],
    );
  }
}

class Event {
  final int id;
  final String title;
  final DateTime startDate;
  final DateTime? endDate;
  final bool isLive;
  final int venueId;
  final String venueName;
  final String city;
  final String state;

  Event({
    required this.id,
    required this.title,
    required this.startDate,
    this.endDate,
    required this.isLive,
    required this.venueId,
    required this.venueName,
    required this.city,
    required this.state,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      title: json['title'],
      startDate: DateTime.parse(json['start_date']),
      endDate:
          json['end_date'] != null ? DateTime.parse(json['end_date']) : null,
      isLive: json['is_live'] == 1,
      venueId: json['venue_id'],
      venueName: json['venue_name'],
      city: json['city'],
      state: json['state'],
    );
  }
}
