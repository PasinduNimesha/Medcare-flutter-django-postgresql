import 'package:flutter/material.dart';
import 'package:mediconnect/repository/user_repository.dart';
import 'dart:convert';
import 'package:mediconnect/screens/common_screens/create_account%20&%20login/login/LoginScreen.dart';
import '../../widgets/facebook_sign_in_button.dart';
import '../../widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

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
  final userRepository = UserRepository();
  String? _deviceId;
 
  Future getDeviceId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? deviceId = prefs.getString('device_id');

    if (deviceId == null) {
      // Generate a random unique ID (you can use any approach here)
      deviceId = _generateRandomId();
      await prefs.setString('device_id', deviceId);
    }

    _deviceId = deviceId;
  }

  String _generateRandomId() {
    var random = Random();
    return List.generate(16, (index) => random.nextInt(9).toString()).join();
  }

void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Create Account Error'), 
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
  void initState() {
    super.initState();
    getDeviceId();
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
                      onPressed: () async {
                        print('Creating account...');

                       var response = await userRepository.createUser(
                            user: jsonEncode(<String, String>{
                          'User_ID':
                              DateTime.now().millisecondsSinceEpoch.toString(),
                          'Email': _emailController.text,
                          'Password': _passwordController.text,
                          'Device_ID': _deviceId!
                        }));

                        if(response['status'] == "success") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginScreen()),
                          );
                        }
                        if(response['status'] == "error"){
                          _showErrorDialog(context, response['message']);
                        }
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
