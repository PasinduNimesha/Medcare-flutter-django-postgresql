import 'package:flutter/material.dart';
import 'package:mediconnect/screens/common_screens/create_account%20&%20login/create_account/CreateAccountScreen.dart'; // Import the RegisterScreen

class CreateAnAccount extends StatelessWidget {
  const CreateAnAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const CreateAccountScreen()),
        );
      },
      child: const Text(
        'Create an Account',
        style: TextStyle(color: Colors.black),
        
      ),
    );
  }
}
