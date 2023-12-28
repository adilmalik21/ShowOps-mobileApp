import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class Lodging extends StatefulWidget {
  @override
  _LodgingState createState() => _LodgingState();
}

class _LodgingState extends State<Lodging> {
  List<String> occupants = [];
  DateTime? _checkInDate;
  DateTime? _checkOutDate;

  final _checkInController = TextEditingController();
  final _checkOutController = TextEditingController();

  String? formatDate(DateTime? date) {
    return date != null ? DateFormat('MM/dd/yy h:mma').format(date) : null;
  }

  Future<void> _selectCheckInDateTime(BuildContext context) async {
    DateTime? currentDate = DateTime.now();
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: _checkInDate ?? currentDate,
      firstDate: currentDate,
      lastDate: currentDate.add(Duration(days: 365)),
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

    if (selectedDate != null) {
      TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light(
                primary: Colors.black, // dial background color
                onPrimary: Colors.white, // dial text color
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
        _checkInDate = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        );
        _checkInController.text = formatDate(_checkInDate)!;
      }
    }
  }

  Future<void> _selectCheckOutDateTime(BuildContext context) async {
    DateTime? currentDate = DateTime.now();
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: _checkOutDate ?? currentDate,
      firstDate: currentDate,
      lastDate: currentDate.add(Duration(days: 365)),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.black, // selected color
              onPrimary: Colors.white, // text on selected color
              onSurface: Colors.black, // text on background surface
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );

    if (selectedDate != null) {
      TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light(
                primary: Colors.black, // selected color
                onPrimary: Colors.white, // text on selected color
                onSurface: Colors.black, // text on background surface
              ),
              dialogBackgroundColor: Colors.white,
            ),
            child: child!,
          );
        },
      );

      if (selectedTime != null) {
        _checkOutDate = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        );
        _checkOutController.text = formatDate(_checkOutDate)!;
      }
    }
  }

  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
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
              SizedBox(height: 5),
              const Center(
                child: Text(
                  'Holiday Inn Express',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 5), //adding verticle space
              const Center(
                child: Text(
                  '1441 North Smith Road, Chattanooga, TN 37412',
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                child: Image.asset('assets/images/lodging.png'),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: FaIcon(FontAwesomeIcons.locationDot),
                      onPressed: () {
                        openMap(-3.823216, -38.481700);
                      },
                    ),
                    IconButton(
                      icon: FaIcon(FontAwesomeIcons.phoneFlip),
                      onPressed: () {
                        // ignore: deprecated_member_use
                        launch("tel://21213123123");
                      },
                    ),
                    IconButton(
                      icon: FaIcon(FontAwesomeIcons.link),
                      onPressed: () {
                        _launchURL('https://dev.showops.co/');
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              ExpansionTile(
                title: Text(
                  "Hotel Details",
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
                                child: TextFormField(
                                  controller: _checkInController,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    labelText: 'Check in',
                                    hintText: formatDate(_checkInDate) ??
                                        'Select Date & Time',
                                  ),
                                  onTap: () {
                                    _selectCheckInDateTime(context);
                                  },
                                ),
                              ),
                              SizedBox(width: 20),
                              Expanded(
                                child: TextFormField(
                                  controller: _checkOutController,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    labelText: 'Check out',
                                    hintText: formatDate(_checkOutDate) ??
                                        'Select Date & Time',
                                  ),
                                  onTap: () {
                                    _selectCheckOutDateTime(context);
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10), // Some space between rows
                          Row(
                            children: [
                              Expanded(
                                flex:
                                    2, // Giving more space to confirmation number
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Confirmation Number',
                                  ),
                                ),
                              ),
                              SizedBox(width: 20),
                              Expanded(
                                flex:
                                    1, // Giving lesser space to price as it might be a smaller input
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Price',
                                  ),
                                  textAlign: TextAlign
                                      .center, // To align the text on the trailing end
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Wifi',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      labelText: 'Wifi Network:'),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter network name';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(width: 20.0),
                              Expanded(
                                flex: 2,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      labelText: 'Wifi Password:'),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter the password';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Parking',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: DropdownButtonFormField<String>(
                                  items: ["Yes", "No"].map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (_) {},
                                  decoration: InputDecoration(
                                      labelText: 'Bus Parking:'),
                                ),
                              ),
                              SizedBox(width: 40.0),
                              Expanded(
                                flex: 2,
                                child: DropdownButtonFormField<String>(
                                  items: ["Yes", "No"].map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (_) {},
                                  decoration: InputDecoration(
                                      labelText: 'Shore Power:'),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex:
                                    2, // Giving more space to confirmation number
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Parking Notes:',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Amenities',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 3,
                                child: DropdownButtonFormField<String>(
                                  items: ["Yes", "No"].map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (_) {},
                                  decoration:
                                      InputDecoration(labelText: 'Hot Tub:'),
                                ),
                              ),
                              SizedBox(width: 10.0),
                              Expanded(
                                flex: 2,
                                child: DropdownButtonFormField<String>(
                                  items: ["Yes", "No"].map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (_) {},
                                  decoration:
                                      InputDecoration(labelText: 'Pool:'),
                                ),
                              ),
                              SizedBox(width: 10.0),
                              Expanded(
                                flex: 2,
                                child: DropdownButtonFormField<String>(
                                  items: ["Yes", "No"].map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (_) {},
                                  decoration:
                                      InputDecoration(labelText: 'Gym:'),
                                ),
                              ),
                              SizedBox(width: 10.0),
                              Expanded(
                                flex: 3,
                                child: DropdownButtonFormField<String>(
                                  items: ["Yes", "No"].map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (_) {},
                                  decoration:
                                      InputDecoration(labelText: 'Laundry:'),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex:
                                    2, // Giving more part to confirmation number
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Other:',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 25),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Notes:',
                              style: TextStyle(
                                  fontWeight: FontWeight.normal, fontSize: 15),
                            ),
                          ),
                          SizedBox(
                              height: 10), // Some spacing between label and box
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
                  "Room 1",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Room #:',
                                  ),
                                ),
                              ),
                              SizedBox(width: 20),
                              Expanded(
                                flex: 3,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Confirmation #:',
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Occupants',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15)),
                              IconButton(
                                icon: FaIcon(FontAwesomeIcons.add),
                                onPressed: () {
                                  setState(() {
                                    occupants.add("");
                                  });
                                },
                              ),
                            ],
                          ),
                          ...occupants
                              .map((item) => Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          initialValue: item,
                                          decoration: InputDecoration(
                                            labelText: 'Occupant',
                                          ),
                                          onChanged: (value) {
                                            setState(() {
                                              int index =
                                                  occupants.indexOf(item);
                                              occupants[index] = value;
                                            });
                                          },
                                        ),
                                      ),
                                      IconButton(
                                        icon: FaIcon(FontAwesomeIcons.trashCan),
                                        onPressed: () {
                                          setState(() {
                                            occupants.remove(item);
                                          });
                                        },
                                      ),
                                    ],
                                  ))
                              .toList(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              ExpansionTile(
                title: Text(
                  "Room 2",
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
                  "Room 3",
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
                  "Room 4",
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

void main() => runApp(MaterialApp(home: Lodging()));
