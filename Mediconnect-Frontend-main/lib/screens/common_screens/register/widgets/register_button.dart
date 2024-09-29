import 'package:flutter/material.dart';
import 'package:mediconnect/screens/doctor_screens/doctormain.dart';
import 'package:mediconnect/screens/patient_screens/home/home_page/HomePage.dart';

class RegisterButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String selectedRole; // Add selectedRole to determine where to redirect

  const RegisterButton({
    super.key,
    required this.onPressed,
    required this.selectedRole,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ElevatedButton(
        onPressed: () {
          // Perform registration logic
          onPressed();
      
          // Check the selected role and navigate accordingly
          if (selectedRole == "Doctor") {
            // Navigate to Doctor's Home Screen
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const DoctorHomeScreen()),
            );
          } else if (selectedRole == "Patient") {
            // Navigate to Patient's Home Screen
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          } else {
            // Handle any other cases if necessary
          }
        },
        child: const Text('Register'),
      ),
    );
  }
}
