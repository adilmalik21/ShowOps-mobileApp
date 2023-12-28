import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:local_auth/local_auth.dart';
import 'package:showops/login.dart'; // Ensure this import points to your login screen
import 'package:http/http.dart' as http;

class SettingsView extends StatefulWidget {
  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool _isBiometricEnabled = false;
  IconData biometricIcon = Icons.fingerprint; // Default to fingerprint
  final LocalAuthentication auth = LocalAuthentication();

  @override
  void initState() {
    super.initState();
    _loadBiometricStatus();
  }

  Future<void> _loadBiometricStatus() async {
    final prefs = await SharedPreferences.getInstance();
    bool? biometricStatus = prefs.getBool('biometricAuth');
    if (biometricStatus != null) {
      setState(() {
        _isBiometricEnabled = biometricStatus;
      });
    }

    try {
      // Check available biometrics
      List<BiometricType> availableBiometrics =
          await auth.getAvailableBiometrics();

      if (availableBiometrics.contains(BiometricType.face)) {
        setState(() {
          biometricIcon = Icons.face; // If face is available, use face icon
        });
      } else if (availableBiometrics.contains(BiometricType.fingerprint)) {
        setState(() {
          biometricIcon = Icons.fingerprint; // Fallback to fingerprint
        });
      }
    } catch (e) {
      // Handle the exception
      print("Error checking biometrics: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error checking biometrics: $e")),
      );
    }
  }

  Future<void> _updateBiometricStatus(bool newValue) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('biometricAuth', newValue);
    setState(() {
      _isBiometricEnabled = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.person),
            title: Text('My Profile'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Implement navigation or actions here
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.security),
            title: Text('Password & Security'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Implement navigation or actions here
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notifications'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Implement navigation or actions here
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Log Out'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () async {
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              final String? token = prefs.getString('token');

              if (token != null) {
                try {
                  final response = await http.get(
                    Uri.parse('https://dev.showops.co/api/logout'),
                    headers: {
                      'Authorization': 'Bearer $token',
                      'Content-Type': 'application/json',
                    },
                  );

                  if (response.statusCode == 200) {
                    await prefs.remove('token');
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content:
                              Text("An error occurred while logging out.")),
                    );
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text("An error occurred while logging out.")),
                  );
                }
              } else {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              }
            },
          ),
          Divider(),
          SwitchListTile(
            title: Text('Enable Biometric Authentication'),
            value: _isBiometricEnabled,
            onChanged: (bool value) async {
              bool canAuthenticate = await auth.canCheckBiometrics;
              List<BiometricType> availableBiometrics =
                  await auth.getAvailableBiometrics();

              if (canAuthenticate && availableBiometrics.isNotEmpty) {
                // Check which biometrics are available and update accordingly
                bool hasFingerprint =
                    availableBiometrics.contains(BiometricType.fingerprint);
                bool hasFace = availableBiometrics.contains(BiometricType.face);

                // You can add additional logic here to handle various scenarios,
                // e.g., if only fingerprint is available or only face ID is available, etc.

                if (hasFingerprint || hasFace) {
                  // Proceed to enable or disable biometric authentication
                  _updateBiometricStatus(value);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content:
                            Text("Biometric authentication is not set up.")),
                  );
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text("No biometric authentication available.")),
                );
              }
            },
            secondary: Icon(biometricIcon),
          ),
        ],
      ),
    );
  }
}
