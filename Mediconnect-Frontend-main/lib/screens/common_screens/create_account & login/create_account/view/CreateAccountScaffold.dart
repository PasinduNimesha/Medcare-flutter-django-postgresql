import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Import the http package
import 'dart:convert'; // For encoding the data
import 'package:mediconnect/screens/common_screens/create_account%20&%20login/create_account/widgets/CreateAccountButton.dart';
import 'package:mediconnect/screens/patient_screens/home/home_page/HomePage.dart';
import '../../widgets/facebook_sign_in_button.dart';
import '../../widgets/widgets.dart';

class CreateAccountScaffold extends StatefulWidget {
  const CreateAccountScaffold({super.key});

  @override
  State<CreateAccountScaffold> createState() => _CreateAccountScaffoldState();
}

class _CreateAccountScaffoldState extends State<CreateAccountScaffold> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();
  final _roleController = TextEditingController();
  final _nicController = TextEditingController();
  final _deviceIdController = TextEditingController();
  final _birthdayController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();

  Future<void> createAccount() async {
    // The URL of your API endpoint
    const String apiUrl = 'http://192.168.43.214:8000/users/create/';

    try {
      // Make the POST request
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'Username': _usernameController.text,
          'Role': _roleController.text,
          'Email': _emailController.text,
          'Password': _passwordController.text,
          'NIC': _nicController.text,
          'Device_ID': _deviceIdController.text,
          'Birthday': _birthdayController.text,
          'First_name': _firstNameController.text,
          'Last_name': _lastNameController.text,
        }),
      );

      if (response.statusCode == 200) {
        // If the server returns an OK response, handle success
        final data = jsonDecode(response.body);
        print('Account created successfully: $data');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Account created successfully!')),
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        // If the server returns an error response
        print('Failed to create account: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to create account')),
        );
      }
    } catch (e) {
      // Handle any errors that occur during the request
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundImage(), // Use the background image
          BlurredBox(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        hintText: 'Enter your email',
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter your password',
                      ),
                      obscureText: true,
                    ),
                   
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        print('Creating account...');
                        createAccount();
                      },
                      child: const Text('Create Account'),
                    ),
                    const SizedBox(height: 20),
                    const Text('Or', style: TextStyle(color: Colors.black)),
                    const SizedBox(height: 10),
                    GoogleSignInButton(),
                    const SizedBox(height: 10),
                    FacebookSignInButton(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Dispose of controllers when the widget is removed
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _roleController.dispose();
    _nicController.dispose();
    _deviceIdController.dispose();
    _birthdayController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }
}
