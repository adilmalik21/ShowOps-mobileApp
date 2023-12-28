import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Talent extends StatefulWidget {
  @override
  _TalentState createState() => _TalentState();
}

class _TalentState extends State<Talent> {
  String? _selectedArtist;
  final List<String> _artists = ['Artist1', 'Artist2', 'Artist3', 'Artist4'];

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
              Center(
                child: DropdownButton<String>(
                  value: _selectedArtist,
                  hint: Text(
                    'Select Artist',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedArtist = newValue;
                    });
                  },
                  items: _artists.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 5),
              // const Center(
              //   child: Text(
              //     '21 Choo Choo Ave, Chattanooga, TN 37402',
              //     style: TextStyle(
              //       fontSize: 15,
              //     ),
              //   ),
              // ),
              // SizedBox(height: 5),
              // const Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Text(
              //       'Capacity: 1500',
              //       style: TextStyle(
              //         fontSize: 15,
              //       ),
              //     ),
              //     SizedBox(width: 30), // Add some spacing between the two texts
              //     Text(
              //       'Type: Club',
              //       style: TextStyle(
              //         fontSize: 15,
              //       ),
              //     ),
              //   ],
              // ),
              const SizedBox(height: 5),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                child: Image.asset('assets/images/talent.png'),
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
                      icon: FaIcon(FontAwesomeIcons.spotify),
                      onPressed: () {
                        _launchURL('https://spotify.com/');
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
              // SizedBox(height: 10),
              ExpansionTile(
                title: const Text(
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
                                        'subject=App Feedback&body=Feedback:', // add the subject and body if you want
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
                title: const Text(
                  "Booking Contact",
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
                                icon: FaIcon(FontAwesomeIcons.envelope),
                                onPressed: () async {
                                  final Uri params = Uri(
                                    scheme: 'mailto',
                                    path:
                                        'example@example.com', // Replace with your email or the intended recipient's email
                                    query:
                                        'subject=App Feedback&body=Feedback:', // add the subject and body if you want
                                  );

                                  String url = params.toString();
                                  if (await canLaunch(url)) {
                                    await launch(url);
                                  } else {
                                    throw 'Could not launch $url';
                                  }
                                },
                              ),
                              IconButton(
                                icon: FaIcon(FontAwesomeIcons.phoneFlip),
                                onPressed: () {
                                  // Handle Instagram button press
                                  launch("tel://21213123123");
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
                  "Production Contact",
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
                  "Artist Management",
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
                  "Tour Manager",
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

void main() => runApp(MaterialApp(home: Talent()));
