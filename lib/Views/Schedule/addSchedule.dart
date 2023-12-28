import 'package:flutter/material.dart';

class AddSchedule extends StatefulWidget {
  final bool isAdmin;
  AddSchedule({required this.isAdmin}); // Modify the constructor
  @override
  _AddScheduleState createState() => _AddScheduleState();
}

class _AddScheduleState extends State<AddSchedule> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _zipController = TextEditingController();

  void _addSchedule() {
    if (_formKey.currentState!.validate()) {
      // Send tickets
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(widget.isAdmin
              ? 'Tickets sent successfully!'
              : 'Tickets requested successfully!')));
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
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              // Added SingleChildScrollView
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      'Add to Schedule',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: 'Title'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: 'Location'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a location';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _phoneController,
                    decoration: InputDecoration(labelText: 'Event'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter an event';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _zipController,
                    decoration: InputDecoration(labelText: 'Visibility'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter visibility';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  Text('Notes:',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  SizedBox(height: 5), // Some spacing between label and box
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
                  SizedBox(height: 35),
                  Row(
                    mainAxisAlignment: MainAxisAlignment
                        .center, // Center the buttons in the row
                    children: [
                      ElevatedButton(
                        onPressed: _addSchedule,
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
                        child: const Text('Add',
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

void main() {
  runApp(MaterialApp(home: AddSchedule(isAdmin: false)));
}
