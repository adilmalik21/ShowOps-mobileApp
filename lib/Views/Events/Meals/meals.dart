import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Meals extends StatefulWidget {
  @override
  _MealsState createState() => _MealsState();
}

class _MealsState extends State<Meals> {
  DateTime? _startTime;
  DateTime? _endTime;

  final _startTimeController = TextEditingController();
  final _endTimeController = TextEditingController();

  String? formatTime(DateTime? date) {
    return date != null ? DateFormat('h:mma').format(date) : null;
  }

  Future<void> _selectStartTime(BuildContext context) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.black, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.black, // body text color
            ),
            dialogBackgroundColor:
                Colors.white, // background color of the dialog
          ),
          child: child!,
        );
      },
    );

    if (selectedTime != null) {
      _startTime = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        selectedTime.hour,
        selectedTime.minute,
      );
      _startTimeController.text = formatTime(_startTime)!;
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.black, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.black, // body text color
            ),
            dialogBackgroundColor:
                Colors.white, // background color of the dialog
          ),
          child: child!,
        );
      },
    );

    if (selectedTime != null) {
      _endTime = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        selectedTime.hour,
        selectedTime.minute,
      );
      _endTimeController.text = formatTime(_endTime)!;
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
              ExpansionTile(
                title: Text(
                  "Breakfast",
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
                            'Reservation Information',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: TextFormField(
                                  controller: _startTimeController,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    labelText: 'Start Time',
                                    hintText: formatTime(_startTime) ??
                                        'Select start time',
                                  ),
                                  onTap: () {
                                    _selectStartTime(context);
                                  },
                                ),
                              ),
                              SizedBox(width: 20),
                              Expanded(
                                flex: 1,
                                child: TextFormField(
                                  controller: _endTimeController,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    labelText: 'End Time',
                                    hintText: formatTime(_endTime) ??
                                        'Select end time',
                                  ),
                                  onTap: () {
                                    _selectEndTime(context);
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Caterer Info',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex:
                                    2, // Giving more space to confirmation number
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Company Name:',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex:
                                    2, // Giving more space to confirmation number
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Contact Name:',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex:
                                    2, // Giving more space to confirmation number
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Phone Number:',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex:
                                    2, // Giving more space to confirmation number
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Email:',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Menu',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex:
                                    2, // Giving more space to confirmation number
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Appetizers:',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex:
                                    2, // Giving more space to confirmation number
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Entrees:',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex:
                                    2, // Giving more space to confirmation number
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Sides:',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex:
                                    2, // Giving more space to confirmation number
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Desserts:',
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 10),
                          Text('Additional Notes:',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15)),
                          SizedBox(
                              height: 5), // Some spacing between label and box
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
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              ExpansionTile(
                title: Text(
                  "Lunch",
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
                            'Bay Out',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              ExpansionTile(
                title: Text(
                  "Dinner",
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
                  "Post Show",
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

void main() => runApp(MaterialApp(home: Meals()));
