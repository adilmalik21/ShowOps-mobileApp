import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Files extends StatefulWidget {
  @override
  _FilesState createState() => _FilesState();
}

class _FilesState extends State<Files> {
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
              // SizedBox(height: 200),
              ExpansionTile(
                title: const Text(
                  "Contracts",
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
                title: const Text(
                  "Marketing",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                // Commented out the leading icon as we don't want it
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
                  "Parking Photos",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                // Commented out the leading icon as we don't want it
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
                  "Stage",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                // Commented out the leading icon as we don't want it
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
            ],
          ),
        ),
      ),
    );
  }
}
