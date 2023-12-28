import 'package:flutter/material.dart';

class CreateAllocation extends StatefulWidget {
  @override
  _CreateAllocationState createState() => _CreateAllocationState();
}

class _CreateAllocationState extends State<CreateAllocation> {
  String? selectedRecipient;

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
        centerTitle: true, // Ensure the title is centered
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
              SizedBox(height: 10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Create Allocation',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Choose Recipient:',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              DropdownButton<String>(
                value: selectedRecipient,
                isExpanded: true, // This will make the dropdown expanded
                hint: Text("Choose Stakeholder"),
                items: const [
                  DropdownMenuItem(
                    value: "Stakeholder 1",
                    child: Text("Stakeholder 1"),
                  ),
                  DropdownMenuItem(
                    value: "Stakeholder 2",
                    child: Text("Stakeholder 2"),
                  ),
                ],
                onChanged: (newValue) {
                  setState(() {
                    selectedRecipient = newValue!;
                  });
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
              const SizedBox(
                  height:
                      20), // Add some spacing between the text fields and buttons
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Center the buttons in the row
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Handle Allocate button press
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 82, 85, 90),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      elevation:
                          15, // Set the elevation to adjust the shadow effect
                    ),
                    child: const Text('Create Allocation',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
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
    );
  }
}

void main() {
  runApp(MaterialApp(home: CreateAllocation()));
}
