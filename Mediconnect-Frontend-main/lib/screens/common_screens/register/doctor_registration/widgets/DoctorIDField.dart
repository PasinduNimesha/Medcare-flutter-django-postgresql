import 'package:flutter/material.dart';

class DoctorIDField extends StatelessWidget {
  final TextEditingController doctorIDController;

  const DoctorIDField({required this.doctorIDController, super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: TextFormField(
        controller: doctorIDController,
        decoration: const InputDecoration(labelText: 'Doctor ID'),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your Doctor ID';
          }
          return null;
        },
      ),
    );
  }
}
