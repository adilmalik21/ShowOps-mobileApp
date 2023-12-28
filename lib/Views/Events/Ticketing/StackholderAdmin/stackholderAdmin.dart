import 'package:flutter/material.dart';
import 'package:showops/Views/Events/Ticketing/sendTickets.dart';

class StackholderAdmin extends StatelessWidget {
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
        child: SingleChildScrollView(
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
                SizedBox(height: 15),
                // Add table here
                Table(
                  border: TableBorder.all(),
                  columnWidths: const {
                    0: FlexColumnWidth(0.9),
                    1: FlexColumnWidth(0.8),
                    2: FlexColumnWidth(0.5),
                    3: FlexColumnWidth(0.8),
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
                          child: Text('Ticket Type',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Allocation',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Used',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Remaining',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    // Data Rows

                    const TableRow(children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('VIP'),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('8'),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('10'),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('2'),
                      ),
                    ]),
                    const TableRow(children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('General Admission'),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('15'),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('10'),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('5'),
                      ),
                    ]),
                  ],
                ),

                SizedBox(height: 20),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Confirmed',
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
                    3: FlexColumnWidth(0.8),
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

                SizedBox(height: 20),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Requested',
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
                    3: FlexColumnWidth(0.8),
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

                    TableRow(children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Randy Humphries'),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Jason Wall'),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('4'),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                _showDetailsDialog(
                                  context,
                                  'Jason Wall',
                                  'Humphries',
                                  'randy@platform.com',
                                  '(615) 123-4567',
                                );
                              },
                              child: const Icon(
                                Icons.check,
                                //color: Color(0xff9dc451),
                              ),
                            ),
                            const SizedBox(width: 5),
                            const Icon(Icons.close),
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
                            Icon(
                              Icons.check,
                              color: Color(0xff9dc451),
                            ),
                            SizedBox(width: 5),
                            Icon(Icons.close),
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
      ),
    );
  }

  void _showDetailsDialog(BuildContext context, String requester, String name,
      String email, String phone) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Approve Comp Request',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Requested by: $requester'),
                SizedBox(height: 10),
                Text('Name: $name'),
                SizedBox(height: 10),
                Text('Email: $email'),
                SizedBox(height: 10),
                Text('Phone: $phone'),
                SizedBox(height: 20),
                Table(
                  border: TableBorder.all(),
                  children: const [
                    // Header Row
                    TableRow(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Type',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        // making text bold
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Requested',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        // making text bold
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Approved',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        // making text bold
                      ],
                    ),
                    // Other Rows
                    TableRow(children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('VIP'),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('4'),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('4'),
                      ),
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('General Admission'),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('6'),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('6'),
                      ),
                    ]),
                  ],
                ),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Approve', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 82, 85, 90),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                elevation: 15, // Set the elevation to adjust the shadow effect
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle the Approve action here
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 82, 85, 90),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                elevation: 15, // Set the elevation to adjust the shadow effect
              ),
            ),
          ],
        );
      },
    );
  }
}
