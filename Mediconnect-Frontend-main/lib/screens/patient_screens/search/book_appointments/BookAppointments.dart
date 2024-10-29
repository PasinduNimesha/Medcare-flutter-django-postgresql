import 'package:flutter/material.dart';
import 'view/view.dart';

class AppointmentPage extends StatelessWidget {
  final String doctorName;
  final Map<String, dynamic> searchData; 
  final String hospital;


  const AppointmentPage({
    super.key,
    required this.doctorName, required this.searchData, required this.hospital,
  });

  @override
  Widget build(BuildContext context) {
    return BookAppointmentsscaffold(doctorName: doctorName, searchData: searchData,hospital: hospital,);
  }
}
