import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:showops/login.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;

  ResetPasswordScreen({Key? key, required this.email}) : super(key: key);

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> _resetPassword() async {
    if (!_formKey.currentState!.validate()) return;

    final response = await http.post(
      Uri.parse('https://dev.showops.co/api/reset_password'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': widget.email,
        'code': _codeController.text,
        'password': _passwordController.text,
        'password_confirmation': _confirmPasswordController.text,
      }),
    );

    final jsonResponse = json.decode(response.body);
    if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(jsonResponse['message'])),
      );
      // Navigate to LoginScreen after a short delay
      Future.delayed(Duration(seconds: 10), () {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginScreen()),
          (Route<dynamic> route) => false,
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(jsonResponse['message'])),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: SingleChildScrollView(
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
                      'Reset Password',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                        fontFamily: 'Nunito',
                      ),
                    ),
                  ),
                  SizedBox(height: 30.0),

                  Text(
                    'Please enter the reset password code sent to your email: ${widget.email}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 18.0,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Nunito',
                    ),
                  ),
                  SizedBox(height: 20.0),

                  // Reset Code Field
                  TextFormField(
                    controller: _codeController,
                    decoration: InputDecoration(labelText: 'Reset Code:'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter reset code';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20.0),

                  // Password Field
                  TextFormField(
                    obscureText: true,
                    controller: _passwordController,
                    decoration: InputDecoration(labelText: 'New Password:'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter new password';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10.0),

                  // Confirm Password Field
                  TextFormField(
                    obscureText: true,
                    controller: _confirmPasswordController,
                    decoration:
                        InputDecoration(labelText: 'Confirm New Password:'),
                    validator: (value) {
                      if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 40.0),

                  ElevatedButton(
                    onPressed: _resetPassword,
                    // onPressed: () {
                    //   if (_formKey.currentState!.validate()) {
                    //     // Submit reset password request
                    //   }
                    // },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF2c333d),
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text('Submit',
                        style: TextStyle(
                            color: Colors.white, fontFamily: 'Nunito')),
                  ),
                  SizedBox(height: 20.0),

                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Back to Login',
                      style: TextStyle(
                        color: Colors.grey[700],
                        decoration: TextDecoration.underline,
                        fontFamily: 'Nunito',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _codeController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
