import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mediconnect/repository/appointment_repository.dart';
import 'package:mediconnect/screens/patient_screens/home/home_page/HomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppointmentDetailsWidget extends StatefulWidget {
  final String doctorName;
  final int? selectedNumber;
  final ValueChanged<int?> onSelectNumber;
  final ValueChanged<String> onConsultationTypeChanged;
  final ValueChanged<String> onNoteChanged;
  final VoidCallback onPlaceAppointment;
  final String hospital;
  final Map<String, dynamic> searchData;

  const AppointmentDetailsWidget({
    super.key,
    required this.doctorName,
    required this.selectedNumber,
    required this.onSelectNumber,
    required this.onConsultationTypeChanged,
    required this.onNoteChanged,
    required this.onPlaceAppointment,
    required this.hospital,
    required this.searchData,
  });

  @override
  State<AppointmentDetailsWidget> createState() =>
      _AppointmentDetailsWidgetState();
}

class _AppointmentDetailsWidgetState extends State<AppointmentDetailsWidget> {
  Map<String, dynamic>? visitData;
  final AppointmentRepository appointmentRepository = AppointmentRepository();
  int? token_no;
  @override
  void initState() {
    super.initState();
    fetchDoctorVisit();
    getUserId();
  }

  String? _userId;

  Future getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('user_id');
    _userId = userId;
  }

  Future<Map<String, dynamic>> fetchDoctorVisit() async {
    print("${widget.searchData['DoctorId']}");
    final uri = Uri.parse(
        "http://10.0.2.2:8000/api/visit/${widget.searchData['DoctorId']}/${widget.searchData['HospitalId']}");
    final response = await http.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );
    final data = jsonDecode(response.body);
    if (data['status'] == "success") {
      setState(() {
        visitData = data['data'];
      });
      return data['data'];
    } else {
      throw Exception('Failed to load search results');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Make an Appointment with ${widget.doctorName}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Doctor name: Dr. ${widget.doctorName}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Medical Center: ${widget.hospital}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.location_on),
                TextButton(
                  onPressed: () {
                    // Handle See Location press
                  },
                  child: const Text(
                    'See Location',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Date: ${widget.searchData['Date']}',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              'Available Numbers',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            DropdownButton<int>(
                value: token_no,
                onChanged: (int? newValue) {
                  setState(() {
                    token_no = newValue;
                  });
                },
                items: visitData != null
                    ? List.generate(
                            visitData?['AP_Count'], (index) => index + 1)
                        .map<DropdownMenuItem<int>>((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text(value.toString()),
                        );
                      }).toList()
                    : [1, 2, 3].map<DropdownMenuItem<int>>((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text(value.toString()),
                        );
                      }).toList()),
            const SizedBox(height: 16),
            const Text(
              'Approx. time',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              '11:00 AM',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            const Text(
              'This time may vary. So make sure to visit the medical center/hospital on time',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () =>
                      widget.onConsultationTypeChanged('In-person'),
                  child: const Text('In-person'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 116, 198, 236),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => widget.onConsultationTypeChanged('Online'),
                  child: const Text('Online'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'My note',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'John Doe - Chest Pain',
                ),
                onChanged: widget.onNoteChanged,
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  var response = await appointmentRepository.createAppointment(
                      appointment: jsonEncode({
                    "Patient_ID": 1,
                    "Doctor_ID": widget.searchData['DoctorId'],
                    "Start_time": visitData!['AP_Start_Time'].toString(),
                    "End_time": visitData!['AP_End_Time'].toString(),
                    "Date": widget.searchData['Date'].toString(),
                    "Hospital_ID": widget.searchData['HospitalId'],
                    "Disease": widget.searchData['Disease'],
                    "Token_no": token_no
                  }));
                  if (response['status'] == "success") {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text(
                              'Appointment Placed successfully')),
                    );
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) =>  HomePage()));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text(
                              'Error Making Appointment')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize:
                      const Size(double.infinity, 50), // Full-width button
                ),
                child: const Text(
                  'Place Appointment',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
