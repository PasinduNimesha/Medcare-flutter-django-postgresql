import 'package:flutter/material.dart';

class NICField extends StatelessWidget {
  final TextEditingController nicController;

  const NICField({super.key, required this.nicController});

  // NIC Validation Logic
  String? _validateNIC(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your NIC';
    }

    // Check if the NIC is 10 or 12 characters long
    if (value.length == 10) {
      // Validate the format for old NICs (e.g., 123456789V or 123456789X)
      if (RegExp(r'^\d{9}[VXvx]$').hasMatch(value)) {
        return null; // Valid NIC
      } else {
        return 'Invalid NIC format. Should be 9 digits followed by V or X.';
      }
    } else if (value.length == 12) {
      // Validate the format for new NICs (e.g., 200123456789)
      if (RegExp(r'^\d{12}$').hasMatch(value)) {
        return null; // Valid NIC
      } else {
        return 'Invalid NIC format. Should be 12 digits.';
      }
    } else {
      return 'NIC should be either 10 or 12 characters long.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.85), // Blurred background
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        controller: nicController,
        decoration: const InputDecoration(labelText: 'NIC'),
        validator: _validateNIC,
      ),
    );
  }
}
