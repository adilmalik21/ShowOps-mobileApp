import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart'; // Make sure this path is correct for your HomeScreen
import 'login.dart'; // Make sure this path is correct for your LoginScreen

void main() {
  runApp(MyApp());
}

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }

  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _getStoredAuthToken(),
      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data != null && snapshot.data!.isNotEmpty) {
            return MaterialApp(
              title: 'Login App',
              theme: ThemeData(
                primarySwatch: createMaterialColor(
                    Color(0xff9dc451)), // Sets primary color to green
                fontFamily: 'Nunito',
                appBarTheme: AppBarTheme(
                  color: Colors.white,
                  elevation: 0.0,
                  iconTheme: IconThemeData(color: Colors.black),
                ),
              ),
              home: HomeScreen(),
            );
          } else {
            return MaterialApp(
              title: 'Login App',
              theme: ThemeData(
                primaryColor: Color(0xff9dc451), // Sets primary color to green
                fontFamily: 'Nunito',
                appBarTheme: AppBarTheme(
                  color: Colors.white,
                  elevation: 0.0,
                  iconTheme: IconThemeData(color: Colors.black),
                ),
              ),
              home: LoginScreen(),
            );
          }
        }
        return MaterialApp(
          title: 'Login App',
          theme: ThemeData(
            primaryColor: Color(
                0xff9dc451), // Colors.green, // Sets primary color to green
            fontFamily: 'Nunito',
          ),
          home: Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  const SizedBox(
                    width: 50.0,
                    height: 50.0,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                      strokeWidth: 5.0,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text("Loading...",
                      style: TextStyle(fontSize: 18, color: Colors.grey[600])),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<String?> _getStoredAuthToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    final bool isBiometricEnabled = prefs.getBool('biometricAuth') ?? false;

    if (token != null && isBiometricEnabled) {
      final LocalAuthentication auth = LocalAuthentication();
      bool canAuthenticate = await auth.canCheckBiometrics;

      if (canAuthenticate) {
        try {
          bool didAuthenticate = await auth.authenticate(
            localizedReason: 'Please authenticate to access the app',
          );

          if (didAuthenticate) {
            return token; // Successful biometric authentication
          }
        } catch (e) {
          // Biometric authentication error handling
          print("Biometric authentication error: $e");
        }
      }
    } else if (token != null) {
      return token;
    }

    return null; // No token or biometric authentication not enabled/failed
  }
}
