import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  Future<void> _checkLoginCredentials(
      BuildContext context, String email, String password) async {
    final url = Uri.parse('https://your-backend-url.com/api/login/');
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

      if (/*response.statusCode*/200 == 200) {
        // If the server returns a 200 OK response, navigate to home screen
        Navigator.pushNamed(context, '/home');
      } else if (response.statusCode == 401) {
        // Invalid credentials
        _showErrorDialog(context, 'Incorrect email or password.');
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
          title: const Text('Login Failed'),
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
        final email = 'user@example.com'; // Replace with actual email input value
        final password = 'password123'; // Replace with actual password input value
        _checkLoginCredentials(context, email, password);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent,
      ),
      child: const Text('Login'),
    );
  }
}
