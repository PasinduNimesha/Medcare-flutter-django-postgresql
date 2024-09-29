import 'package:flutter/material.dart';
import '../widgets/widgets.dart'; // Import all widgets from the widgets.dart file
import 'package:qr_flutter/qr_flutter.dart';
import 'package:mediconnect/widgets/bottom_nav_bar/PatientBottomNavBar.dart';
import 'package:mediconnect/screens/common_screens/switch_user/switchUser.dart';
import 'package:mediconnect/screens/patient_screens/home/appointment_details/AppointmentDetailsScreen.dart';
import 'package:mediconnect/themes/AppointmentStatusColors.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePageScaffold extends StatefulWidget {
  const HomePageScaffold({super.key});

  @override
  _HomePageScaffoldState createState() => _HomePageScaffoldState();
}

class _HomePageScaffoldState extends State<HomePageScaffold> {
  final String userEmail = "johndoe@example.com";
  List<dynamic> appointments = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse(
          'https://gist.githubusercontent.com/Madushansuriyabandara/b4b46ac4e1e90095759f3b7fb277c203/raw/b0fe08959d0b321f7afeb5fcb8189fdb97c0de8e/appointments.json'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          appointments = data['appointments'];
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.switch_account),
            onPressed: () {
              switchUser(context);
            },
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: QrImageView(
                      data: userEmail,
                      size: 200.0,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'My Appointments',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: appointments.length,
                      itemBuilder: (context, index) {
                        final appointment = appointments[index];
                        return AppointmentButton(
                          color: getAppointmentStatusColor(
                              appointment['appointmentStatus']),
                          text:
                              '${appointment['appointmentName']} - ${appointment['doctorName']}',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AppointmentDetailsScreen(
                                  appointmentName:
                                      appointment['appointmentName'],
                                  doctorName: appointment['doctorName'],
                                  specialty: appointment['specialty'],
                                  appointmentTime:
                                      appointment['appointmentTime'],
                                  appointmentDate:
                                      appointment['appointmentDate'],
                                  location: appointment['location'],
                                  appointmentNumber:
                                      appointment['appointmentNumber'],
                                  currentNumber: appointment['currentNumber'],
                                  turnTime: appointment['turnTime'],
                                  appointmentStatus:
                                      appointment['appointmentStatus'],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
      bottomNavigationBar: PatientBottomNavBar(
        currentIndex: 2,
        onTap: (index) {
          // Handle bottom navigation tap
        },
      ),
    );
  }
}
