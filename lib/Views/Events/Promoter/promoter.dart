import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Promoter extends StatefulWidget {
  @override
  _PromoterState createState() => _PromoterState();
}

class _PromoterState extends State<Promoter> {
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
              SizedBox(height: 200),
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
                          const SizedBox(
                              height:
                                  5), // Add a little spacing between the lines
                          Text(
                            'Company: Marathon Live',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(
                              height:
                                  5), // Add a little spacing between the lines
                          Text(
                            'Title: Venue Director',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(
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
                  "Day Of Show Contact",
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
                title: const Text(
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
                title: const Text(
                  "Marketing Contact",
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
                  ), // padding ends here
                  // Add more content or widgets here if needed
                ],
              ),
              ExpansionTile(
                title: const Text(
                  "Runner",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                // Commented out the leading icon as its not needed here
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
