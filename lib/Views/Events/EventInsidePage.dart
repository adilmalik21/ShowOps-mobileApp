import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showops/Views/Events/Files/files.dart';
import 'package:showops/Views/Events/Lodging/lodging.dart';
import 'package:showops/Views/Events/Meals/meals.dart';
import 'package:showops/Views/Events/Production/production.dart';
import 'package:showops/Views/Events/Promoter/promoter.dart';
import 'package:showops/Views/Events/SetList/setList.dart';
import 'package:showops/Views/Events/Talent/talent.dart';
import 'package:showops/Views/Events/Venue/venueDetails.dart';
import 'package:showops/Views/Events/Ticketing/Ticketing.dart';

class EventInsidePage extends StatefulWidget {
  final int eventId;

  EventInsidePage({Key? key, required this.eventId}) : super(key: key);

  @override
  _EventInsidePageState createState() => _EventInsidePageState();
}

class _EventInsidePageState extends State<EventInsidePage> {
  EventDetail? eventDetail;

  @override
  void initState() {
    super.initState();
    _fetchEventDetail();
  }

  Future<void> _fetchEventDetail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    final response = await http.get(
      Uri.parse('https://dev.showops.co/api/event/${widget.eventId}'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse['status'] == 'success') {
        setState(() {
          eventDetail = EventDetail.fromJson(jsonResponse['data']);
        });
      }
    } else {
      // Handle error response
      print('Something went wrong!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            AppBar(
              title: Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.cover,
                height: 45,
              ),
              centerTitle: true,
              backgroundColor: Colors.white,
            ),
            eventDetail == null
                ? CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Color(0xff9dc451)),
                  )
                : Center(
                    child: Text(
                      '${DateFormat('MMMM dd, yyyy - h:mma').format(DateTime.parse(eventDetail!.startDate))}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
            eventDetail == null
                ? SizedBox()
                : Center(
                    child: Text(
                      '${eventDetail!.venue.name} - ${eventDetail!.venue.city}, ${eventDetail!.venue.state}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ),
            const SizedBox(height: 5.0),
            Expanded(
              child: ListView(
                children: [
                  Divider(),
                  ListTile(
                    title: const Text('Ticketing'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Ticketing()),
                      );
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Venue'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => VenueDetails()),
                      );
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Promoter'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Promoter()),
                      );
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Talent'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Talent()),
                      );
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Lodging'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Lodging()),
                      );
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Meals'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Meals()),
                      );
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Set List'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SetList()),
                      );
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Budget'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // Navigate to the Budget screen
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Production'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Production()),
                      );
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Files'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Files()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EventDetail {
  final int id;
  final String title;
  final String startDate;
  final Venue venue;
  final EventUserRoles eventUserRoles;
  final List<String> eventPermissions;

  EventDetail({
    required this.id,
    required this.title,
    required this.startDate,
    required this.venue,
    required this.eventUserRoles,
    required this.eventPermissions,
  });

  factory EventDetail.fromJson(Map<String, dynamic> json) {
    return EventDetail(
      id: json['id'],
      title: json['title'],
      startDate: json['start_date'],
      venue: Venue.fromJson(json['venue']),
      eventUserRoles: EventUserRoles.fromJson(json['event_user_roles']),
      eventPermissions: List<String>.from(json['event_permissions']),
    );
  }
}

class Venue {
  final int id;
  final String name;
  final String city;
  final String state;

  Venue({
    required this.id,
    required this.name,
    required this.city,
    required this.state,
  });

  factory Venue.fromJson(Map<String, dynamic> json) {
    return Venue(
      id: json['id'],
      name: json['name'],
      city: json['city'],
      state: json['state'],
    );
  }
}

class EventUserRoles {
  final bool eventPromoter;
  final bool eventArtist;
  final int financeType;
  final bool eventCreator;
  final bool eventOwner;
  final bool ticketOwner;
  final bool eventVenue;

  EventUserRoles({
    required this.eventPromoter,
    required this.eventArtist,
    required this.financeType,
    required this.eventCreator,
    required this.eventOwner,
    required this.ticketOwner,
    required this.eventVenue,
  });

  factory EventUserRoles.fromJson(Map<String, dynamic> json) {
    return EventUserRoles(
      eventPromoter: json['event_promoter'],
      eventArtist: json['event_artist'],
      financeType: json['finance_type'],
      eventCreator: json['event_creator'],
      eventOwner: json['event_owner'],
      ticketOwner: json['ticket_owner'],
      eventVenue: json['event_venue'],
    );
  }
}
