import 'package:flutter/material.dart';

Color getAppointmentStatusColor(String appointmentStatus) {
  switch (appointmentStatus) {
    case 'Queued':
      return Colors.yellow;
    case 'Completed':
      return Colors.green;
    case 'Missed':
      return Colors.red;
    case 'Upcoming':
      return Colors.blue;
    default:
      return Colors.grey;
  }
}
