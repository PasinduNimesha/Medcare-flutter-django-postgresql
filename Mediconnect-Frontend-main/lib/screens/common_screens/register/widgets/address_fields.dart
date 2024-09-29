import 'package:flutter/material.dart';

class AddressFields extends StatelessWidget {
  final TextEditingController streetNoController;
  final TextEditingController streetNameController;
  final TextEditingController cityController;
  final TextEditingController postalCodeController;

  const AddressFields({
    super.key,
    required this.streetNoController,
    required this.streetNameController,
    required this.cityController,
    required this.postalCodeController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.85), // Blurred background
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Address',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: streetNoController,
            decoration: const InputDecoration(labelText: 'Street No.'),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: streetNameController,
            decoration: const InputDecoration(labelText: 'Street Name/s'),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: cityController,
            decoration: const InputDecoration(labelText: 'City'),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: postalCodeController,
            decoration: const InputDecoration(labelText: 'Postal Code'),
          ),
        ],
      ),
    );
  }
}
