import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

class PrescriptionsScaffold extends StatelessWidget {
  final List<Map<String, dynamic>> prescriptions = [
    {
      'date': 'February 15, 2024',
      'doctor': 'Dr. John Doe (Cardiac Surgeon)',
      'medications': [
        'Panadine 20mg - 10 tablets',
        'Digene 5mg - 5 tablets',
        'Pantodac 10mg - 10 tablets',
      ],
      'progress': 60,
      'keywords': ['Gastritis'],
    },
    {
      'date': 'January 15, 2024',
      'doctor': 'Dr. Will Churchill (Orthopedic Surgeon)',
      'medications': [
        'Panadine 20mg - 10 tablets',
        'Digene 5mg - 5 tablets',
        'Pantodac 10mg - 10 tablets',
      ],
      'progress': 90,
      'keywords': ['Gastritis'],
    },
    {
      'date': 'December 23, 2023',
      'doctor': 'Dr. Will Churchill (Orthopedic Surgeon)',
      'medications': [
        'Panadine 20mg - 10 tablets',
        'Digene 5mg - 5 tablets',
        'Pantodac 10mg - 10 tablets',
      ],
      'progress': 100,
      'keywords': ['Gastritis'],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: prescriptions.length,
      itemBuilder: (context, index) {
        final prescription = prescriptions[index];
        return PrescriptionCard(prescription: prescription);
      },
    );
  }
}
