import 'package:flutter/material.dart';

class SpecializationDropdown extends StatelessWidget {
  final String? selectedSpecialization;
  final Function(String?) onSpecializationChanged;

  SpecializationDropdown({
    required this.selectedSpecialization,
    required this.onSpecializationChanged,
  });

  final List<String> specializations = [
    'Cardiologist',
    'Orthopedic Surgeon',
    'General Practitioner',
    'Dermatologist',
    'Neurologist',
    'Other'
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      child: DropdownButtonFormField<String>(
        decoration: const InputDecoration(labelText: 'Specialization'),
        value: selectedSpecialization,
        onChanged: onSpecializationChanged,
        items: specializations.map((String specialization) {
          return DropdownMenuItem<String>(
            value: specialization,
            child: Text(specialization),
          );
        }).toList(),
      ),
    );
  }
}
