import 'package:flutter/material.dart';

class SendTickets extends StatefulWidget {
  final bool isAdmin;
  SendTickets({required this.isAdmin}); // Modify the constructor
  @override
  _SendTicketsState createState() => _SendTicketsState();
}

class _SendTicketsState extends State<SendTickets> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _zipController = TextEditingController();

  void _sendTickets() {
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
                  Text(
                    widget.isAdmin ? 'Send Tickets' : 'Request Tickets',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: 'Name'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: 'Email'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter an email';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _phoneController,
                    decoration: InputDecoration(labelText: 'Phone'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a phone number';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _zipController,
                    decoration: InputDecoration(labelText: 'Zip'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a zip code';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 35),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Ticket Type',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Quantity',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'VIP',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      Container(
                        width: 100,
                        height: 30,
                        child: TextField(
                          decoration: InputDecoration(
                            // hintText: 'Enter Quantity',

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(width: 0.5),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'General Admission',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      Container(
                        width: 100,
                        height: 30,
                        child: TextField(
                          decoration: InputDecoration(
                            // hintText: 'Enter Quantity',

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(width: 0.5),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
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
                        onPressed: _sendTickets,
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
                        child: const Text('Send',
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
  runApp(MaterialApp(home: SendTickets(isAdmin: false)));
}
