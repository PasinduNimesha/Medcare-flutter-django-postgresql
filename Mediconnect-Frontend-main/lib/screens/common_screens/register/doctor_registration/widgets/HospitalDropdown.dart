import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class HospitalDropdown extends StatefulWidget {
  final String? selectedHospital;
  final Function(String?) onHospitalChanged;

  HospitalDropdown({
    required this.selectedHospital,
    required this.onHospitalChanged,
  });

  @override
  State<HospitalDropdown> createState() => _HospitalDropdownState();
}

class _HospitalDropdownState extends State<HospitalDropdown> {
  final List<String> hospitals = [
    'Cardiologist',
    'Orthopedic Surgeon',
    'General Practitioner',
    'Dermatologist',
    'Neurologist',
    'Other'
  ];

  Future<List<Map<String, dynamic>>> _fetchMedicalCenters() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8000/api/hospitals/'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['data'] as List).map((center) {
        return {
          'Hospital_ID':
              center['Hospital_ID'].toString(), // Ensure ID is a string
          'Hospital_Name': center['Name'] + ' - ' + center['Location']
        };
      }).toList();
    } else {
      throw Exception('Failed to load medical centers');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchMedicalCenters(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Text('No medical centers available');
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Hospital',
                ),
                items: snapshot.data!.map((center) {
                  return DropdownMenuItem<String>(
                    value: center['Hospital_ID'], // The ID is stored as value
                    child:
                        Text(center['Hospital_Name']!), // The name is displayed
                  );
                }).toList(),
                onChanged: widget.onHospitalChanged,
                value: widget.selectedHospital,
              ),
            );
          }
        },
      ),
    );
  }
}
