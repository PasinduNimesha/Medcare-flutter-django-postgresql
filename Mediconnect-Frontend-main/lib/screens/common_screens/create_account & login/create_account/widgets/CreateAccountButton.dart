import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mediconnect/screens/common_screens/register/patient_registration/PatientRegistrationForm.dart'; // Import Register Screen
import 'dart:convert';


class CreateAccountButton extends StatelessWidget {
  const CreateAccountButton({super.key});

  Future<void> _registerAccount(BuildContext context, String email, String password) async {
    final url = Uri.parse('https://your-backend-url.com/api/register/');
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, navigate to the Register Screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PatientRegistrationForm()),
        );
      } else if (response.statusCode == 401) {
        // Account creation failed
        _showErrorDialog(context, 'Email already in use or invalid credentials.');
      } else {
        _showErrorDialog(context, 'Something went wrong. Try again.');
      }
    } catch (error) {
      _showErrorDialog(context, 'Error connecting to the server.');
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Account Creation Failed'),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        final email = 'newuser@example.com'; // Replace with actual email input value
        final password = 'password123'; // Replace with actual password input value
        _registerAccount(context, email, password);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
      ),
      child: const Text('Create Account'),
    );
  }
}
