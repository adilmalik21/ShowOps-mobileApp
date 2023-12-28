import 'package:flutter/material.dart';
import 'package:showops/Views/Events/Ticketing/NonAdmin/nonAdmin.dart';
import 'package:showops/Views/Events/Ticketing/StackholderAdmin/stackholderAdmin.dart';
import 'package:showops/Views/Events/Ticketing/TicketingOwner/ticketingOwner.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Ticketing extends StatelessWidget {
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
        child: SingleChildScrollView(
          // Added SingleChildScrollView here
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
                const SizedBox(height: 20),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Ticketing',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Center(
                    child: SizedBox(
                  height: 200.0,
                  width: 200.0,
                  child: Container(
                    child: SfRadialGauge(axes: <RadialAxis>[
                      RadialAxis(minimum: 0, maximum: 100, ranges: <GaugeRange>[
                        GaugeRange(
                            startValue: 0,
                            endValue: 50,
                            color: Color.fromARGB(255, 68, 71, 68)),
                        GaugeRange(
                            startValue: 50,
                            endValue: 100,
                            color: Color.fromARGB(0, 109, 106, 106)),
                      ], pointers: const <GaugePointer>[
                        NeedlePointer(value: 50)
                      ], annotations: <GaugeAnnotation>[
                        GaugeAnnotation(
                            widget: Container(
                                child: const Text('50%',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold))),
                            angle: 90,
                            positionFactor: 0.8)
                      ])
                    ]),
                  ),
                )),
                SizedBox(height: 20),
                Table(
                  border: TableBorder.all(),
                  columnWidths: const {
                    0: FlexColumnWidth(2),
                    1: FlexColumnWidth(1),
                    2: FlexColumnWidth(1),
                    3: FlexColumnWidth(1),
                  },
                  children: [
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
                          child: Text('Price',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Sold',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Gross',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    const TableRow(children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('VIP'),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('\$50'),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('25/100'),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('\$1250'),
                      ),
                    ]),
                    const TableRow(children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('General Admission'),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('\$30'),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('300/400'),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('\$9000'),
                      ),
                    ]),
                    const TableRow(children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Totals'),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(''),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('325/500'),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('\$10250'),
                      ),
                    ]),
                  ],
                ),
                SizedBox(height: 20),
                ListTile(
                  title: const Text('Comps'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Wrap(
                          children: <Widget>[
                            ListTile(
                              leading: Icon(Icons.person),
                              title: const Text('Ticketing Owner'),
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TicketingOwner()),
                                );
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.admin_panel_settings),
                              title: const Text('Stakeholder Admin'),
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => StackholderAdmin()),
                                );
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.person_outline),
                              title: const Text('Non-Admin'),
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NonAdmin()),
                                );
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                ListTile(
                  title: const Text('Door Sales/Scanning'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
