import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class VenueDetails extends StatefulWidget {
  @override
  _VenueDetailsState createState() => _VenueDetailsState();
}

class _VenueDetailsState extends State<VenueDetails> {
  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }

  _launchURL($url) async {
    final Uri url = Uri.parse($url);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Image.asset(
          'assets/images/logo.png',
          fit: BoxFit.cover,
          height: 45,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: ListView(
            children: [
              const Center(
                child: Text(
                  'Sep 13, 2023 - 7:30pm',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              const Center(
                child: Text(
                  'The Signal - Chattanooga, TN',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(height: 5),
              Divider(thickness: 1.0),
              SizedBox(height: 5),
              const Center(
                child: Text(
                  'The Signal',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 5),
              const Center(
                child: Text(
                  '21 Choo Choo Ave, Chattanooga, TN 37402',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Capacity: 1500',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(width: 30), // Add some spacing between the two texts
                  Text(
                    'Type: Club',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                child: Image.asset('assets/images/venue.png'),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: FaIcon(FontAwesomeIcons.image),
                      onPressed: () {
                        // _makePhoneCall('+12402074933');
                      },
                    ),
                    IconButton(
                      icon: FaIcon(FontAwesomeIcons.locationDot),
                      onPressed: () {
                        openMap(-3.823216, -38.481700);
                      },
                    ),
                    IconButton(
                      icon: FaIcon(FontAwesomeIcons.phoneFlip),
                      onPressed: () {
                        // ignore: deprecated_member_use
                        launch("tel://21213123123");
                      },
                    ),
                    IconButton(
                      icon: FaIcon(FontAwesomeIcons.link),
                      onPressed: () {
                        _launchURL('https://dev.showops.co/');
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              ExpansionTile(
                title: Text(
                  "Venue Details",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: TextFormField(
                          decoration:
                              InputDecoration(labelText: 'Wifi Network:'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter network name';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                        flex: 2,
                        child: TextFormField(
                          decoration:
                              InputDecoration(labelText: 'Wifi Password:'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter the password';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(width: 10.0),
                      IconButton(
                        icon: FaIcon(FontAwesomeIcons.copy),
                        onPressed: () {
                          // Handle the copy action here
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                      height: 10.0), // Gives a little spacing between the rows
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Dressing Rooms:'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter dressing rooms';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                      height: 10.0), // Gives a little spacing between the rows
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 4,
                        child: TextFormField(
                          decoration: InputDecoration(labelText: 'Showers:'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter the number of showers';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(width: 40.0),
                      Expanded(
                        flex: 2,
                        child: DropdownButtonFormField<String>(
                          items: ["Yes", "No"].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (_) {},
                          decoration: InputDecoration(labelText: 'Laundry:'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                      height: 10.0), // Gives a little spacing between the rows
                  TextFormField(
                    decoration: InputDecoration(labelText: 'General Parking:'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter General Parking';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                      height: 10.0), // Gives a little spacing between the rows
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Bus Parking:'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Bus Parking';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                      height: 10.0), // Gives a little spacing between the rows
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: DropdownButtonFormField<String>(
                          items: ["Yes", "No"].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (_) {},
                          decoration:
                              InputDecoration(labelText: 'Shore Power:'),
                        ),
                      ),
                      SizedBox(width: 40.0),
                      Expanded(
                        flex: 4,
                        child: TextFormField(
                          decoration: InputDecoration(labelText: ''),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter value';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Notes:',
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 15),
                    ),
                  ),
                  SizedBox(height: 10), // Some spacing between label and box
                  Container(
                    height: 100, // or any desired height
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      maxLines:
                          null, // This allows unlimited lines for the text input
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      ),
                    ),
                  ),

                  SizedBox(height: 15.0),
                  // Place multimedia and social icons here
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(
                        icon: FaIcon(FontAwesomeIcons.facebookF),
                        onPressed: () {
                          // Handle Facebook button press
                          _launchURL('https://facebook.com/');
                        },
                      ),
                      IconButton(
                        icon: FaIcon(FontAwesomeIcons.instagram),
                        onPressed: () {
                          // Handle Instagram button press
                          _launchURL('https://instagram.com/');
                        },
                      ),
                      IconButton(
                        icon: FaIcon(FontAwesomeIcons.youtube),
                        onPressed: () {
                          // Handle YouTube button press
                          _launchURL('https://youtube.com/');
                        },
                      ),
                      IconButton(
                        icon: FaIcon(FontAwesomeIcons.twitter),
                        onPressed: () {
                          // Handle Twitter button press
                          _launchURL('https://twitter.com/');
                        },
                      ),
                      IconButton(
                        icon: FaIcon(FontAwesomeIcons.tiktok),
                        onPressed: () {
                          // Handle TikTok button press
                          _launchURL('https://tiktok.com/');
                        },
                      ),
                    ],
                  )
                ],
              ),
              ExpansionTile(
                title: Text(
                  "Primary Contact",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Name: Jason Wall',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(
                              height:
                                  5), // Add a little spacing between the lines
                          Text(
                            'Company: Marathon Live',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(
                              height:
                                  5), // Add a little spacing between the lines
                          Text(
                            'Title: Venue Director',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(
                              height: 15), // Add some spacing before the icons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              IconButton(
                                icon: FaIcon(FontAwesomeIcons.sms),
                                onPressed: () {
                                  // Replace with your phone number
                                  launch("sms:+1234567890");
                                },
                              ),
                              IconButton(
                                icon: FaIcon(FontAwesomeIcons.phoneFlip),
                                onPressed: () {
                                  // Handle Instagram button press
                                  launch("tel://21213123123");
                                },
                              ),
                              IconButton(
                                icon: FaIcon(FontAwesomeIcons.envelope),
                                onPressed: () async {
                                  final Uri params = Uri(
                                    scheme: 'mailto',
                                    path:
                                        'example@example.com', // Replace with your email or the intended recipient's email
                                    query:
                                        'subject=App Feedback&body=Feedback:', // add the subject and body if required
                                  );

                                  String url = params.toString();
                                  if (await canLaunch(url)) {
                                    await launch(url);
                                  } else {
                                    throw 'Could not launch $url';
                                  }
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              ExpansionTile(
                title: Text(
                  "Production Manager",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                // Commented out the leading icon as you don't want it
                // leading: Icon(Icons.list),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Your detailed information goes here. You can provide any additional details, like email, phone number, etc.',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                  // Add more content or widgets if you want
                ],
              ),
              ExpansionTile(
                title: Text(
                  "Marketing Manager",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                // Commented out the leading icon as you don't want it
                // leading: Icon(Icons.list),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Your detailed information goes here. You can provide any additional details, like email, phone number, etc.',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                  // Add more content or widgets if you want
                ],
              ),
              ExpansionTile(
                title: Text(
                  "Ticketing Manager",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                // Commented out the leading icon as you don't want it
                // leading: Icon(Icons.list),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Your detailed information goes here. You can provide any additional details, like email, phone number, etc.',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                  // Add more content or widgets if you want
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: VenueDetails()));
