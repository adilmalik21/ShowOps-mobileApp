import 'package:flutter/material.dart';
import 'package:showops/Views/Events/Ticketing/TicketingOwner/createAllocation.dart';
import 'package:showops/Views/Events/Ticketing/sendTickets.dart';

class TicketingOwner extends StatelessWidget {
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Comps',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Handle Allocate button press
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateAllocation()),
                          );
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
                        child: const Text('Allocate',
                            style: TextStyle(color: Colors.white)),
                      ),
                      const SizedBox(
                          width: 10), // Add space between the buttons
                      ElevatedButton(
                        onPressed: () {
                          // Handle Send button press
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SendTickets(
                                      isAdmin: true,
                                    )),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 82, 85, 90),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          elevation:
                              15, // Set the elevation to adjust the shadow effect
                        ),
                        child: const Text('Send',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 5),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Allocations',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 5),
              // Add table here
              Table(
                border: TableBorder.all(),
                columnWidths: const {
                  0: FlexColumnWidth(0.9),
                  1: FlexColumnWidth(1.2),
                  2: FlexColumnWidth(0.7),
                  3: FlexColumnWidth(0.7),
                  4: FlexColumnWidth(1),
                },
                children: [
                  // Header Row
                  TableRow(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                    ),
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Date',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Requester',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Total',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Sent',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  // Data Rows

                  const TableRow(children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('9/23/23'),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('KLOVE'),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('6'),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('4'),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(Icons.edit_note_outlined),
                          SizedBox(width: 5),
                          Icon(Icons.delete_outline_outlined),
                        ],
                      ),
                    ),
                  ]),
                  const TableRow(children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('9/24/23'),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Unspoken'),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('20'),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('10'),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(Icons.edit_note_outlined),
                          SizedBox(width: 5),
                          Icon(Icons.delete_outline_outlined),
                        ],
                      ),
                    ),
                  ]),
                ],
              ),

              SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Comps',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 5),
              // Add table here
              Table(
                border: TableBorder.all(),
                columnWidths: const {
                  0: FlexColumnWidth(1),
                  1: FlexColumnWidth(1),
                  2: FlexColumnWidth(0.9),
                  3: FlexColumnWidth(1),
                },
                children: [
                  // Header Row
                  TableRow(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                    ),
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Name',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Requester',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Quantity',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  // Data Rows

                  const TableRow(children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Randy Humphries'),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Jason Wall'),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('4'),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(Icons.email_outlined),
                          SizedBox(width: 5),
                          Icon(Icons.delete_outline_outlined),
                        ],
                      ),
                    ),
                  ]),
                  const TableRow(children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Lott Shudde'),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Sarah Comardelle'),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('6'),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(Icons.email_outlined),
                          SizedBox(width: 5),
                          Icon(Icons.delete_outline_outlined),
                        ],
                      ),
                    ),
                  ]),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
