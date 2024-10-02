import 'package:flutter/material.dart';

class HospitalDropdown extends StatelessWidget {
  final String? selectedHospital;
  final Function(String?) onHospitalChanged;

  HospitalDropdown({
    required this.selectedHospital,
    required this.onHospitalChanged,
  });

  final List<String> hospitals = [
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
        decoration: const InputDecoration(labelText: 'Hospital'),
        value: selectedHospital,
        onChanged: onHospitalChanged,
        items: hospitals.map((String specialization) {
          return DropdownMenuItem<String>(
            value: specialization,
            child: Text(specialization),
          );
        }).toList(),
      ),
    );
  }
}
