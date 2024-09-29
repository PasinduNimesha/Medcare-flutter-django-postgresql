import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mediconnect/screens/patient_screens/search/search_page/widgets/widgets.dart';
import 'package:mediconnect/screens/patient_screens/search/search_results/SearchResults.dart';
import 'package:mediconnect/widgets/bottom_nav_bar/PatientBottomNavBar.dart';
//import '../../view/view.dart';

class SearchPagescaffold extends StatefulWidget {
  const SearchPagescaffold({super.key});

  @override
  _SearchPageScaffoldState createState() => _SearchPageScaffoldState();
}

class _SearchPageScaffoldState extends State<SearchPagescaffold> {
  String? selectedDoctor;
  String? selectedMedicalCenter;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String? disease;

  final TextEditingController diseaseController = TextEditingController();

  // Fetch doctors and medical centers from backend
  Future<List<String>> _fetchDoctors() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:8000/'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((doctor) => doctor['name'] as String).toList();
    } else {
      throw Exception('Failed to load doctors');
    }
  }

  Future<List<String>> _fetchMedicalCenters() async {
    final response = await http.get(Uri.parse('https://your-backend-url.com/api/medical-centers'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((center) => center['name'] as String).toList();
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
          doctorName: selectedDoctor,
          disease: disease,
          medicalCenter: selectedMedicalCenter,
          date: selectedDate != null ? DateFormat('yyyy-MM-dd').format(selectedDate!) : null,
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
            FutureBuilder<List<String>>(
              future: _fetchDoctors(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return const Text('Error loading doctors');
                } else {
                  return DropdownField(
                    labelText: 'Search by Doctor Name',
                    items: snapshot.data!,
                    onChanged: (String? value) {
                      setState(() {
                        selectedDoctor = value;
                      });
                    },
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
            const SizedBox(height: 10),

            // Search by Medical Center/Hospital
            FutureBuilder<List<String>>(
              future: _fetchMedicalCenters(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return const Text('Error loading medical centers');
                } else {
                  return DropdownField(
                    labelText: 'Search by Medical Center',
                    items: snapshot.data!,
                    onChanged: (String? value) {
                      setState(() {
                        selectedMedicalCenter = value;
                      });
                    },
                  );
                }
              },
            ),
            const SizedBox(height: 10),

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
                padding: const EdgeInsets.symmetric(horizontal: 150, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: const BorderSide(color: Colors.black, width: 2.0), // Black border
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
