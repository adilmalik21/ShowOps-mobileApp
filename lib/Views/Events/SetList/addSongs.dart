import 'package:flutter/material.dart';

class AddSongs extends StatefulWidget {
  // final bool isAdmin;
  // SendTickets({required this.isAdmin}); // Modify the constructor
  @override
  _AddSongsState createState() => _AddSongsState();
}

class _AddSongsState extends State<AddSongs> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

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
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              // Added SingleChildScrollView
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  SizedBox(height: 5),
                  const Center(
                    child: Text(
                      'The Signal - Chattanooga, TN',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  // SizedBox(height: 5),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: 'Song Title:'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a Song Title';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: 'Nick Name:'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Nick Name';
                      }
                      return null;
                    },
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: TextFormField(
                          decoration: InputDecoration(labelText: 'BPM:'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter BPM';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(width: 30.0),
                      Expanded(
                        flex: 2,
                        child: TextFormField(
                          decoration: InputDecoration(labelText: 'Key:'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter the Key';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(width: 30.0),
                      Expanded(
                        flex: 2,
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Length:', hintText: "00:00:00"),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter the Length';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment
                        .center, // Center the buttons in the row
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Handle add song button press
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 82, 85, 90),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          elevation:
                              15, // Set the elevation to adjust the shadow effect
                        ),
                        child: const Text('Add Song',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(
                          width: 10), // Add some spacing between the buttons
                      TextButton(
                        onPressed: () {
                          // Handle the Cancel button press here
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel',
                            style: TextStyle(
                                color: Color.fromARGB(255, 82, 85, 90),
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
