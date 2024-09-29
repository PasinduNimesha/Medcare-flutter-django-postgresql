import 'package:flutter/material.dart';
import '../widgets/widgets.dart'; // Import the widgets
import 'package:mediconnect/themes/AppointmentStatusColors.dart'; // Adjust the import path
import 'package:http/http.dart' as http;
import 'dart:convert';

class AppointmentDetailsScaffold extends StatelessWidget {
  final String appointmentName;
  final String doctorName;
  final String specialty;
  final String appointmentTime;
  final String appointmentDate;
  final String location;
  final int appointmentNumber;
  final int currentNumber;
  final String turnTime;
  final String appointmentStatus;

  AppointmentDetailsScaffold({
    super.key,
    required this.appointmentName,
    required this.doctorName,
    required this.specialty,
    required this.appointmentTime,
    required this.appointmentDate,
    required this.location,
    required this.appointmentNumber,
    required this.currentNumber,
    required this.turnTime,
    required this.appointmentStatus,
  });

  Future<void> removeAppointment(BuildContext context) async {
    final response = await http.delete(Uri.parse('your-backend-url')); // Replace with your backend URL
    if (response.statusCode == 200) {
      // Navigate back to Home and show a success message
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Appointment removed successfully')),
      );
    } else {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to remove the appointment')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isCompleted = appointmentStatus == 'Completed';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointment Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: const Icon(Icons.person, size: 40),
              title: Text(
                "$doctorName - $appointmentName",
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              subtitle: Text("$doctorName ($specialty)"),
            ),
            const Divider(height: 30),
            ListTile(
              leading: const Icon(Icons.calendar_today, size: 40),
              title: Text(
                appointmentTime,
                style: const TextStyle(fontSize: 18),
              ),
              subtitle: Text(appointmentDate),
            ),
            ListTile(
              leading: const Icon(Icons.location_on, size: 40),
              title: Text(location),
            ),
            const SizedBox(height: 20),
            Text(
              "My number: $appointmentNumber",
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "Current attending number: $currentNumber",
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              "My turn at (approx.): $turnTime",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              width: double.infinity,
              color: getAppointmentStatusColor(appointmentStatus),
              child: Center(
                child: Text(
                  "Appointment Status: $appointmentStatus",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: isCompleted
                      ? () {
                          Navigator.pushNamed(context, '/ratePage', arguments: doctorName);
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isCompleted ? Colors.blue : Colors.grey,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  ),
                  child: const Text(
                    "Rate",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    removeAppointmentConfirmationDialog(context, () => removeAppointment(context));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  ),
                  child: const Text(
                    "Remove Appointment",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
