import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mediconnect/screens/patient_screens/search/book_appointments/widgets/widgets.dart';

class BookAppointmentsscaffold extends StatefulWidget {
  final String doctorName;

  const BookAppointmentsscaffold({
    super.key,
    required this.doctorName,
  });

  @override
  _BookAppointmentsScaffoldState createState() =>
      _BookAppointmentsScaffoldState();
}

class _BookAppointmentsScaffoldState extends State<BookAppointmentsscaffold> {
  int? selectedNumber;
  String appointmentNote = '';
  String consultationType = 'In-person';

  Future<void> placeAppointment() async {
    final uri = Uri.parse('https://your-backend-url.com/api/place-appointment/');
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'doctor_name': widget.doctorName,
        'consultation_type': consultationType,
        'selected_number': selectedNumber,
        'note': appointmentNote,
      }),
    );

    if (response.statusCode == 200) {
      // Successfully placed the appointment
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Appointment successfully placed!')),
      );
    } else {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to place the appointment.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppointmentDetailsWidget(
      doctorName: widget.doctorName,
      selectedNumber: selectedNumber,
      onSelectNumber: (int? newValue) {
        setState(() {
          selectedNumber = newValue;
        });
      },
      onConsultationTypeChanged: (String type) {
        setState(() {
          consultationType = type;
        });
      },
      onNoteChanged: (String note) {
        setState(() {
          appointmentNote = note;
        });
      },
      onPlaceAppointment: placeAppointment,
    );
  }
}
