import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'forgot_password.dart';
import 'home.dart';

import 'APIs/APInetwork_handler.dart';
import 'constants.dart';
import 'Models/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        fontFamily: 'Nunito',
      ),
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordHidden = true;
  final _formKey = GlobalKey<FormState>();
  String? _email, _password;
  bool _isLoading = false;

  bool _rememberEmail = false; // New variable for checkbox state

  TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadEmailPreference();
  }

  Future<void> _loadEmailPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String savedEmail = prefs.getString('email') ?? '';
    setState(() {
      _emailController.text = savedEmail; // Set the controller's text
      _email = savedEmail;
      _rememberEmail = prefs.getBool('rememberEmail') ?? false;
    });
  }

  Future<void> _saveEmailPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', _email!);
    await prefs.setBool('rememberEmail', _rememberEmail);
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordHidden = !_isPasswordHidden;
    });
  }

  bool _isValidEmail(String? email) {
    final RegExp emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
    return emailRegex.hasMatch(email!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 40.0),
                    Center(
                      child: SizedBox(
                        height: 55.0,
                        child: Image.asset('assets/images/logo.png',
                            fit: BoxFit.cover),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Center(
                      child: Text(
                        'Sign in',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                    SizedBox(height: 30.0),

                    // Email Label and TextField
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Email',
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      controller: _emailController, // Use the controller here
                      cursorColor: Colors.grey,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!_isValidEmail(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                      onSaved: (value) => _email = value!.trim(),
                      decoration: InputDecoration(
                        hintText: 'Enter your email',
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: BorderSide(
                              width: 0.5,
                            )),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 2.0),
                        ),
                      ),
                      style: TextStyle(color: Colors.grey[700]),
                    ),

                    SizedBox(height: 20.0),

                    // Password Label and TextField
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Password',
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      cursorColor: Colors.grey,
                      obscureText: _isPasswordHidden,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      onSaved: (value) => _password = value,
                      decoration: InputDecoration(
                        hintText: 'Enter your password',
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(width: 0.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 2.0),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordHidden
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey[600],
                          ),
                          onPressed: _togglePasswordVisibility,
                        ),
                      ),
                      style: TextStyle(color: Colors.grey[700]),
                    ),

                    // Remember Email Checkbox
                    Container(
                      padding: EdgeInsets.only(
                          left: 0.0), // Adjust left padding as needed
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .start, // Align to the start of the Row
                        children: <Widget>[
                          Checkbox(
                              value: _rememberEmail,
                              onChanged: (bool? value) {
                                setState(() {
                                  _rememberEmail = value!;
                                });
                              },
                              activeColor: Color(
                                  0xff9dc451) // Green color for the checkbox
                              ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _rememberEmail = !_rememberEmail;
                              });
                            },
                            child: Text(
                              'Remember Email',
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: _isLoading
                          ? null
                          : () async {
                              setState(() {
                                _isLoading = true; // Start the loading state
                              });

                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();

                                // Create a map for the request body
                                Map<String, String> requestBody = {
                                  "email": _email!,
                                  "password": _password!,
                                };

                                // Call the API
                                NetworkHandler networkHandler =
                                    NetworkHandler(LOGIN_API);
                                final response =
                                    await networkHandler.post(requestBody);
                                final user = User.fromJson(response);
                                print('Printing user: $user.status');

                                // Handle the API response
                                if (user.status == "success") {
                                  // SAVE THE TOKEN HERE:
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  await prefs.setString(
                                      'token', user.userDetails!.token);
                                  await prefs.setString(
                                      'firstName', user.userDetails!.firstName);
                                  await prefs.setString(
                                      'lastName', user.userDetails!.lastName);

                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeScreen()),
                                  );
                                } else if (user.status == "error") {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(user.message)));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              "An unexpected error occurred!")));
                                }
                              }

                              if (_rememberEmail) {
                                await _saveEmailPreference();
                              } else {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                await prefs.remove('email');
                                await prefs.remove('rememberEmail');
                              }

                              setState(() {
                                _isLoading = false; // End the loading state
                              });
                            },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF2c333d),
                        elevation: 15, // Set
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: const Text('Login',
                          style: TextStyle(color: Colors.white)),
                    ),
                    TextButton(
                      //Forgot password button functioning here
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => ForgotPasswordScreen()),
                        );
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Color.fromARGB(255, 16, 45, 69),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 60.0,
                    ),
                    // Center(
                    //   child: RichText(
                    //     textAlign: TextAlign.center,
                    //     text: TextSpan(
                    //       children: [
                    //         TextSpan(
                    //           text: 'Scanning or selling tickets?',
                    //           style: const TextStyle(
                    //             color: Colors.blue,
                    //             decoration: TextDecoration.underline,
                    //           ),
                    //           recognizer: TapGestureRecognizer()
                    //             ..onTap = () {
                    //               // Handle scanning or selling tickets action here
                    //             },
                    //         ),
                    //         TextSpan(
                    //           text: '\nClick here to log in.',
                    //           style: const TextStyle(
                    //             color: Colors.blue,
                    //             decoration: TextDecoration.underline,
                    //           ),
                    //           recognizer: TapGestureRecognizer()
                    //             ..onTap = () {
                    //               // Handle login link action here
                    //             },
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
