import 'package:flutter/material.dart';
import 'view/view.dart';

class AppointmentPage extends StatelessWidget {
  final String doctorName;

  const AppointmentPage({
    super.key,
    required this.doctorName,
  });

  @override
  Widget build(BuildContext context) {
    return BookAppointmentsscaffold(doctorName: doctorName);
  }
}
