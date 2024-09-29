import 'package:flutter/material.dart';
import 'package:mediconnect/screens/common_screens/register/patient_registration/PatientRegistrationForm.dart';
import 'package:mediconnect/screens/common_screens/register/doctor_registration/DoctorRegistrationForm.dart';
import 'dart:ui'; // Required for BackdropFilter

class RoleTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String onPressedRoute;

  const RoleTile({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressedRoute, required Color iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect( // Clip the tile to ensure the blur effect is contained within the tile
      borderRadius: BorderRadius.circular(15),
      child: Stack(
        children: [
          // Blurred background
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0), // Apply the blur
            child: Container(
              color: Colors.white.withOpacity(0.2), // Semi-transparent background
              alignment: Alignment.center,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent, // Transparent button background
                  shadowColor: Colors.transparent, // Remove shadow
                  padding: const EdgeInsets.all(16), // Padding for the button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15), // Rounded corners
                  ),
                ),
                onPressed: () {
                  if (onPressedRoute == 'doctor_registration') {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const DoctorRegistrationForm()),
                    );
                  } else if (onPressedRoute == 'patient_registration') {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const PatientRegistrationForm()),
                    );
                  }
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      icon,
                      size: 100,
                      color: Colors.blue, // Set icon color to blue
                    ),
                    const SizedBox(height: 10),
                    Text(
                      label,
                      style: const TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

