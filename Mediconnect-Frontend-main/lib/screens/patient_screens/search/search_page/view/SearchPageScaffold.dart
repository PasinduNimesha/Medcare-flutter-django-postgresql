import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mediconnect/screens/patient_screens/search/search_page/widgets/widgets.dart';
import 'package:mediconnect/screens/patient_screens/search/search_results/SearchResults.dart';
import 'package:mediconnect/widgets/bottom_nav_bar/PatientBottomNavBar.dart';

class SearchPagescaffold extends StatefulWidget {
  const SearchPagescaffold({super.key});

  @override
  _SearchPageScaffoldState createState() => _SearchPageScaffoldState();
}

class _SearchPageScaffoldState extends State<SearchPagescaffold> {
  String? selectedDoctorId;
  String? selectedMedicalCenterId;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String? disease;

  final TextEditingController diseaseController = TextEditingController();

  // Fetch doctors and medical centers from backend
  Future<List<Map<String, dynamic>>> _fetchDoctors() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8000/api/patient'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['data'] as List).map((doctor) {
        return {
          'Doctor_ID': doctor['Patient_ID'].toString(), // Ensure ID is a string
          'Doctor_Name': 'Dr. ' + doctor['First_name'] + ' ' + doctor['Last_name']
        };
      }).toList();
    } else {
      throw Exception('Failed to load doctors');
    }
  }

  Future<List<Map<String, dynamic>>> _fetchMedicalCenters() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8000/api/hospitals/'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['data'] as List).map((center) {
        return {
          'Hospital_ID':
              center['Hospital_ID'].toString(), // Ensure ID is a string
          'Hospital_Name': center['Name']+' - '+center['Location']
        };
      }).toList();
    } else {
      throw Exception('Failed to load medical centers');
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  void _searchDoctors() {
    // Perform search operation
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchResultsPage(
          doctorName: selectedDoctorId, // Use the selected doctor ID here
          disease: disease,
          medicalCenter:
              selectedMedicalCenterId, // Use the selected medical center ID
          date: selectedDate != null
              ? DateFormat('yyyy-MM-dd').format(selectedDate!)
              : null,
          time: selectedTime?.format(context),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search for a Doctor"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Search by Doctor Name
            FutureBuilder<List<Map<String, dynamic>>>(
              future: _fetchDoctors(),
              builder: (context, snapshot) {
                 if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text('No doctors available');
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Search by Doctor Name',
                      ),
                      items: snapshot.data!.map((doctor) {
                        return DropdownMenuItem<String>(
                          value: doctor['Doctor_ID'], // The ID is stored as value
                          child: Text(
                              doctor['Doctor_Name']!), // The name is displayed
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          selectedDoctorId =
                              value; // Store the selected doctor ID
                        });
                      },
                      value: selectedDoctorId,
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 10),
            FutureBuilder<List<Map<String, dynamic>>>(
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
                        labelText: 'Search by Medical Center',
                      ),
                      items: snapshot.data!.map((center) {
                        return DropdownMenuItem<String>(
                          value:
                              center['Hospital_ID'], // The ID is stored as value
                          child: Text(
                              center['Hospital_Name']!), // The name is displayed
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          selectedMedicalCenterId =
                              value; // Store the selected medical center ID
                        });
                      },
                      value: selectedMedicalCenterId,
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 10),

            // Search by Disease
            TextField(
              controller: diseaseController,
              decoration: const InputDecoration(
                labelText: 'Search by Disease',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  disease = value;
                });
              },
            ),
            const SizedBox(height: 40),

            // Select Date
            DatePickerField(
              selectedDate: selectedDate,
              onDateSelected: () => _selectDate(context),
            ),
            const SizedBox(height: 10),

            // Select Time
            TimePickerField(
              selectedTime: selectedTime,
              onTimeSelected: () => _selectTime(context),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: _searchDoctors,
              child: const Text(
                'Search',
                style: TextStyle(color: Colors.black),
              ),
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 150, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: const BorderSide(
                      color: Colors.black, width: 2.0), // Black border
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: PatientBottomNavBar(
        currentIndex: 1, // Index for the 'Search' tab
        onTap: (index) {
          // Handle navigation
        },
      ),
    );
  }
}
